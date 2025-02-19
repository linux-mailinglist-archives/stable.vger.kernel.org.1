Return-Path: <stable+bounces-118148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2912A3BA78
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3702D1779BE
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED10B1B6D0A;
	Wed, 19 Feb 2025 09:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fNc1JlDb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3902AE74;
	Wed, 19 Feb 2025 09:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739957373; cv=none; b=fajzO6D8VabQuhH/iwovePt55BKnjaU5se8Z1R1jBOONZnKL1bY45qfPqT5zuwYS3LZSHn7kE9rlrCBaKKDR5ycWMzZ5cfcG3bDmBnU9QuKl8xpSYCK8YWST1E56KujF7s7WxfXiDtgKK/leLA1g6UEj8m9JkofoTwFYDMH2B9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739957373; c=relaxed/simple;
	bh=uc38fu+cKlPz/dq2mek1GDOxZIHMNv2VAQF486SAFRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrCpogglEYS6LROjf6hD2QWmRHaArepnsuj3si0WNVOn/ODIeZQ3ZCPNq52scYfjlziMwvPqew5/9JqlhUn1TWgeYAj4llluHvbEQDZ1mspWsHOXGurqKZ9va0crY8NIvmxZhErC6uuaKmkfDbov8Fozqn6WSvWjjf2nlnBHM9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fNc1JlDb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E374C4CED1;
	Wed, 19 Feb 2025 09:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739957373;
	bh=uc38fu+cKlPz/dq2mek1GDOxZIHMNv2VAQF486SAFRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fNc1JlDbuh8cDGZXOqa5k8LiUstUfY2YGiKL8887VIL1Dm3l13bjhpgO6dRW1DXi8
	 NaGXxP07kwwdMrYwl+GwRFNAHDDkCxUs3OyGfhBr9ii5VXfJetjM+bvSSH/8Jqcaxo
	 Y/qdp1fAer2sIGKpFsf7b0tX1mXnOsM4d6Mr2DiA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Elson Roy Serrao <quic_eserrao@quicinc.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 6.1 504/578] usb: roles: set switch registered flag early on
Date: Wed, 19 Feb 2025 09:28:28 +0100
Message-ID: <20250219082712.812001652@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082652.891560343@linuxfoundation.org>
References: <20250219082652.891560343@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Elson Roy Serrao <quic_eserrao@quicinc.com>

commit 634775a752a86784511018a108f3b530cc3399a7 upstream.

The role switch registration and set_role() can happen in parallel as they
are invoked independent of each other. There is a possibility that a driver
might spend significant amount of time in usb_role_switch_register() API
due to the presence of time intensive operations like component_add()
which operate under common mutex. This leads to a time window after
allocating the switch and before setting the registered flag where the set
role notifications are dropped. Below timeline summarizes this behavior

Thread1				|	Thread2
usb_role_switch_register()	|
	|			|
	---> allocate switch	|
	|			|
	---> component_add()	|	usb_role_switch_set_role()
	|			|	|
	|			|	--> Drop role notifications
	|			|	    since sw->registered
	|			|	    flag is not set.
	|			|
	--->Set registered flag.|

To avoid this, set the registered flag early on in the switch register
API.

Fixes: b787a3e78175 ("usb: roles: don't get/set_role() when usb_role_switch is unregistered")
Cc: stable <stable@kernel.org>
Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20250206193950.22421-1-quic_eserrao@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/roles/class.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -354,14 +354,15 @@ usb_role_switch_register(struct device *
 	dev_set_name(&sw->dev, "%s-role-switch",
 		     desc->name ? desc->name : dev_name(parent));
 
+	sw->registered = true;
+
 	ret = device_register(&sw->dev);
 	if (ret) {
+		sw->registered = false;
 		put_device(&sw->dev);
 		return ERR_PTR(ret);
 	}
 
-	sw->registered = true;
-
 	/* TODO: Symlinks for the host port and the device controller. */
 
 	return sw;



