Return-Path: <stable+bounces-115367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2222DA3434F
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 715C4169258
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 14:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC7F281379;
	Thu, 13 Feb 2025 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vqAIlZJi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBFE281349;
	Thu, 13 Feb 2025 14:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457808; cv=none; b=lH9OBglYw4XFmZl9hNu8mJrykpThf/Erf612rM9lBbmM1PO33bx7o0ajY5v/qPADTGmhqo7d/P845jF6FiEf/eXR1jt9b1iSnxrGXKvcFWAOhyPnJgmEIaDcChJOJiKFdONq6UNIF/oZCewoiYNO7eJOcFBesYAm3GKrPKPHag8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457808; c=relaxed/simple;
	bh=Bem96vx1EX5S0Doty1hQeiq5gwCpKG58PtsnUfS9Hzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVldntBVBVser752D5KvQhf9cLFK/0oVBorgjUQZ3EzOeSLrRWayV7DRCDDq3IdPFZLu83/T4vATlhr8Myiz/lNZVPXeTtebQDrB9F3Wd9i3miJF2xkCFxTn0bIST9XiuPfM9FP43Xze8u5npcgLyBlK8q6EUcdQ5lS89pBaO/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vqAIlZJi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44ACC4CED1;
	Thu, 13 Feb 2025 14:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739457808;
	bh=Bem96vx1EX5S0Doty1hQeiq5gwCpKG58PtsnUfS9Hzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vqAIlZJi7MGe920Xz6FdGHXki/lO1/nxRc0gDWiJmF1MVVBS/KsT2L2OqZa1THt+s
	 ujDV9k72Egre5BIAlOMORaOqaDTj0RQbCEGyHLeOmCZQM0akhbtJ/ayF3zusMamvpq
	 YH9j8I9bAGKSOyS8A51wFeRy2bKPUrzs0g7GvdfA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Foster Snowhill <forst@pen.gy>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.12 218/422] usbnet: ipheth: document scope of NCM implementation
Date: Thu, 13 Feb 2025 15:26:07 +0100
Message-ID: <20250213142444.950214820@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142436.408121546@linuxfoundation.org>
References: <20250213142436.408121546@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Foster Snowhill <forst@pen.gy>

commit be154b598fa54136e2be17d6dd13c8a8bc0078ce upstream.

Clarify that the "NCM" implementation in `ipheth` is very limited, as
iOS devices aren't compatible with the CDC NCM specification in regular
tethering mode.

For a standards-compliant implementation, one shall turn to
the `cdc_ncm` module.

Cc: stable@vger.kernel.org # 6.5.x
Signed-off-by: Foster Snowhill <forst@pen.gy>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/ipheth.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -218,6 +218,14 @@ static int ipheth_rcvbulk_callback_legac
 	return ipheth_consume_skb(buf, len, dev);
 }
 
+/* In "NCM mode", the iOS device encapsulates RX (phone->computer) traffic
+ * in NCM Transfer Blocks (similarly to CDC NCM). However, unlike reverse
+ * tethering (handled by the `cdc_ncm` driver), regular tethering is not
+ * compliant with the CDC NCM spec, as the device is missing the necessary
+ * descriptors, and TX (computer->phone) traffic is not encapsulated
+ * at all. Thus `ipheth` implements a very limited subset of the spec with
+ * the sole purpose of parsing RX URBs.
+ */
 static int ipheth_rcvbulk_callback_ncm(struct urb *urb)
 {
 	struct usb_cdc_ncm_nth16 *ncmh;



