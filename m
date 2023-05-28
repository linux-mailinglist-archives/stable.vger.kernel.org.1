Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213CD713DA6
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjE1T1h (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjE1T1g (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:27:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB7DF3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:27:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFCE961C4B
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD148C433EF;
        Sun, 28 May 2023 19:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302052;
        bh=SHXYLRzB+3ea6D63U05bW4ttaTZRJlntcMBkWgK1xWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wmfWkpsCntYRgSoQrkE9HOIte54D4qs84AR1jJEUWT4Qdq1tztjW1b8bfRE8BOpBq
         9KGF8LUSZLRFWFkHLHunSJnGl/MhjfCcj+MJOpI2vmaCgBVOWPXIBYuTeIXDF6zYAQ
         6O0wSeUHWHhdsBBopVj6zabW9sErzsP2HjWnaiyg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 5.4 142/161] USB: core: Add routines for endpoint checks in old drivers
Date:   Sun, 28 May 2023 20:11:06 +0100
Message-Id: <20230528190841.450624872@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190837.051205996@linuxfoundation.org>
References: <20230528190837.051205996@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

commit 13890626501ffda22b18213ddaf7930473da5792 upstream.

Many of the older USB drivers in the Linux USB stack were written
based simply on a vendor's device specification.  They use the
endpoint information in the spec and assume these endpoints will
always be present, with the properties listed, in any device matching
the given vendor and product IDs.

While that may have been true back then, with spoofing and fuzzing it
is not true any more.  More and more we are finding that those old
drivers need to perform at least a minimum of checking before they try
to use any endpoint other than ep0.

To make this checking as simple as possible, we now add a couple of
utility routines to the USB core.  usb_check_bulk_endpoints() and
usb_check_int_endpoints() take an interface pointer together with a
list of endpoint addresses (numbers and directions).  They check that
the interface's current alternate setting includes endpoints with
those addresses and that each of these endpoints has the right type:
bulk or interrupt, respectively.

Although we already have usb_find_common_endpoints() and related
routines meant for a similar purpose, they are not well suited for
this kind of checking.  Those routines find endpoints of various
kinds, but only one (either the first or the last) of each kind, and
they don't verify that the endpoints' addresses agree with what the
caller expects.

In theory the new routines could be more general: They could take a
particular altsetting as their argument instead of always using the
interface's current altsetting.  In practice I think this won't matter
too much; multiple altsettings tend to be used for transferring media
(audio or visual) over isochronous endpoints, not bulk or interrupt.
Drivers for such devices will generally require more sophisticated
checking than these simplistic routines provide.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/dd2c8e8c-2c87-44ea-ba17-c64b97e201c9@rowland.harvard.edu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/usb.c |   76 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/usb.h    |    5 +++
 2 files changed, 81 insertions(+)

--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -209,6 +209,82 @@ int usb_find_common_endpoints_reverse(st
 EXPORT_SYMBOL_GPL(usb_find_common_endpoints_reverse);
 
 /**
+ * usb_find_endpoint() - Given an endpoint address, search for the endpoint's
+ * usb_host_endpoint structure in an interface's current altsetting.
+ * @intf: the interface whose current altsetting should be searched
+ * @ep_addr: the endpoint address (number and direction) to find
+ *
+ * Search the altsetting's list of endpoints for one with the specified address.
+ *
+ * Return: Pointer to the usb_host_endpoint if found, %NULL otherwise.
+ */
+static const struct usb_host_endpoint *usb_find_endpoint(
+		const struct usb_interface *intf, unsigned int ep_addr)
+{
+	int n;
+	const struct usb_host_endpoint *ep;
+
+	n = intf->cur_altsetting->desc.bNumEndpoints;
+	ep = intf->cur_altsetting->endpoint;
+	for (; n > 0; (--n, ++ep)) {
+		if (ep->desc.bEndpointAddress == ep_addr)
+			return ep;
+	}
+	return NULL;
+}
+
+/**
+ * usb_check_bulk_endpoints - Check whether an interface's current altsetting
+ * contains a set of bulk endpoints with the given addresses.
+ * @intf: the interface whose current altsetting should be searched
+ * @ep_addrs: 0-terminated array of the endpoint addresses (number and
+ * direction) to look for
+ *
+ * Search for endpoints with the specified addresses and check their types.
+ *
+ * Return: %true if all the endpoints are found and are bulk, %false otherwise.
+ */
+bool usb_check_bulk_endpoints(
+		const struct usb_interface *intf, const u8 *ep_addrs)
+{
+	const struct usb_host_endpoint *ep;
+
+	for (; *ep_addrs; ++ep_addrs) {
+		ep = usb_find_endpoint(intf, *ep_addrs);
+		if (!ep || !usb_endpoint_xfer_bulk(&ep->desc))
+			return false;
+	}
+	return true;
+}
+EXPORT_SYMBOL_GPL(usb_check_bulk_endpoints);
+
+/**
+ * usb_check_int_endpoints - Check whether an interface's current altsetting
+ * contains a set of interrupt endpoints with the given addresses.
+ * @intf: the interface whose current altsetting should be searched
+ * @ep_addrs: 0-terminated array of the endpoint addresses (number and
+ * direction) to look for
+ *
+ * Search for endpoints with the specified addresses and check their types.
+ *
+ * Return: %true if all the endpoints are found and are interrupt,
+ * %false otherwise.
+ */
+bool usb_check_int_endpoints(
+		const struct usb_interface *intf, const u8 *ep_addrs)
+{
+	const struct usb_host_endpoint *ep;
+
+	for (; *ep_addrs; ++ep_addrs) {
+		ep = usb_find_endpoint(intf, *ep_addrs);
+		if (!ep || !usb_endpoint_xfer_int(&ep->desc))
+			return false;
+	}
+	return true;
+}
+EXPORT_SYMBOL_GPL(usb_check_int_endpoints);
+
+/**
  * usb_find_alt_setting() - Given a configuration, find the alternate setting
  * for the given interface.
  * @config: the configuration to search (not necessarily the current config).
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -279,6 +279,11 @@ void usb_put_intf(struct usb_interface *
 #define USB_MAXINTERFACES	32
 #define USB_MAXIADS		(USB_MAXINTERFACES/2)
 
+bool usb_check_bulk_endpoints(
+		const struct usb_interface *intf, const u8 *ep_addrs);
+bool usb_check_int_endpoints(
+		const struct usb_interface *intf, const u8 *ep_addrs);
+
 /*
  * USB Resume Timer: Every Host controller driver should drive the resume
  * signalling on the bus for the amount of time defined by this macro.


