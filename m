Return-Path: <stable+bounces-245915-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJDjC/5nA2qa5gEAu9opvQ
	(envelope-from <stable+bounces-245915-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:48:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEEB52624A
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9077B30836BB
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B02F3DC85B;
	Tue, 12 May 2026 17:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LSNHWn7J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D303A3CDBDD;
	Tue, 12 May 2026 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778607882; cv=none; b=mMHNOdtuHtt4lRvJPv8msaBdlQelqVzJlk5XPA0M02zvdx3sG+G5uHLDWzSJPUWoImBQm9xYOFszs4IdGsY3+FnvrrLsEiwQkrPIXZbB5eIU6XEaBfUxZ/h+GOBigCFCO22EFoCrKLQ8OrLxcCotYmArLXEFMdwfZ1kjJTM5g54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778607882; c=relaxed/simple;
	bh=sMj4XVx1h0HhREkfgUEgRMBIR+LHu59Eb3BcchQ2WLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WtQ7Hqf0ynyhk/ZbNVeQJK1nZ0uq6a/KRcvYUKCQ3XWpG8BSzURH8qqtPAptRCU5DYJPeaOd1gPi8ka9x6nuJOpUfGZaP+dOsF4t8QX1NUWsU5L0LOA7MyY6DyOw98PsfkZlG+PjIZFJnjrmn37Vn4OHJK3baI/N15bFMDTFYgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LSNHWn7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29912C2BCB0;
	Tue, 12 May 2026 17:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778607882;
	bh=sMj4XVx1h0HhREkfgUEgRMBIR+LHu59Eb3BcchQ2WLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LSNHWn7JoYK42+VZh2Xqyo1VEfyZKzU3uLIWSmELjz5ld3AoQdkSyxZRcf/BXaVXh
	 j433M3iXNUnNBleKYXMpjEy8EyxFgIUfdR4PGW7HE07BVE78p/5gOpaMIh6QeZhAbF
	 7fYTA3RU86Fq8oEIdkXPf8hAF+pwTcAPZHbOIQZE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Martyn Welch <martyn@welchs.me.uk>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 6.12 073/206] staging: vme_user: fix root device leak on init failure
Date: Tue, 12 May 2026 19:38:45 +0200
Message-ID: <20260512173934.395107076@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173932.810559588@linuxfoundation.org>
References: <20260512173932.810559588@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7DEEB52624A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-245915-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,welchs.me.uk:email]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 32c91e8ee039777d0b95b914633fc6a42607959c upstream.

Make sure to deregister and free the root device in case module
initialisation fails.

Fixes: 658bcdae9c67 ("vme: Adding Fake VME driver")
Cc: stable@vger.kernel.org	# 4.9
Cc: Martyn Welch <martyn@welchs.me.uk>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260424104910.2619349-1-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/vme_user/vme_fake.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -1230,6 +1230,8 @@ err_master:
 err_driver:
 	kfree(fake_bridge);
 err_struct:
+	root_device_unregister(vme_root);
+
 	return retval;
 }
 



