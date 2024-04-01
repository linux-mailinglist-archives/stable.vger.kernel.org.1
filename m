Return-Path: <stable+bounces-34317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A44893ED5
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381691C212D6
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BB547A79;
	Mon,  1 Apr 2024 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s7XB7K8z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29B547A74;
	Mon,  1 Apr 2024 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987712; cv=none; b=gEfc0yMJm3UbFDAsMH5qnqAMAl8PE3rEi91u3LKAG1AELirmaKoP9E+os8SzZD5NgkbRDqN8Xxxh492S4+DjzVoFY6ZTmAfAOPlprU8z45GdRyPqNiPLhefjZMDRmW7mUA4X5xYPXoeE1XRJNH+f3l3ohxzzrZztf96IQjOKihs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987712; c=relaxed/simple;
	bh=QtuZXvPGSlsS6Io3HhR6YrkrTvR1KxRqI71LMuCD+kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tji82s1g3qITIRE/davZ4HB2GmfqR0TXOpyu0H6JDT7zi4iAdilXgTQtN3WIxsOa5ly3YZMOTJSo9vqwX2GNg6h5Ydf8Vz3zsgenkr+2aYTn5oGrrfjtgVsQ/a9rdB23ocVFhPL8GuelXf5pzOz1QrK+iAjURc/HE891dT3weLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s7XB7K8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252AFC433C7;
	Mon,  1 Apr 2024 16:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711987712;
	bh=QtuZXvPGSlsS6Io3HhR6YrkrTvR1KxRqI71LMuCD+kw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s7XB7K8zN1RuDJ9Lje5xSuVEAjJ5nAjSQ3xPLYpC5gSIntRjLcL4b0bwZEnymJ2MX
	 AWSErTax8CO3gVEO1DNbRbeFiDx3kM4q38c05DVQ02QZp2zDHh4mY8/wRjJqKcEi9Z
	 AK5Oz/b93/Boq/AuUH/5WigZ5hPBrxC1wTtdCH84=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kyle Tso <kyletso@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 6.8 370/399] usb: typec: tcpm: Update PD of Type-C port upon pd_set
Date: Mon,  1 Apr 2024 17:45:36 +0200
Message-ID: <20240401152600.221018259@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
References: <20240401152549.131030308@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kyle Tso <kyletso@google.com>

commit 17af5050dead6cbcca12c1fcd17e0bb8bb284eae upstream.

The PD of Type-C port needs to be updated in pd_set. Unlink the Type-C
port device to the old PD before linking it to a new one.

Fixes: cd099cde4ed2 ("usb: typec: tcpm: Support multiple capabilities")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Tso <kyletso@google.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20240311172306.3911309-1-kyletso@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/tcpm/tcpm.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -6166,7 +6166,9 @@ static int tcpm_pd_set(struct typec_port
 
 	port->port_source_caps = data->source_cap;
 	port->port_sink_caps = data->sink_cap;
+	typec_port_set_usb_power_delivery(p, NULL);
 	port->selected_pd = pd;
+	typec_port_set_usb_power_delivery(p, port->selected_pd);
 unlock:
 	mutex_unlock(&port->lock);
 	return ret;



