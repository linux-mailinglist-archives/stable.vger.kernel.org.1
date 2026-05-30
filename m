Return-Path: <stable+bounces-259288-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCRIIRRAG2oMAgkAu9opvQ
	(envelope-from <stable+bounces-259288-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 21:52:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E336131D0
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 21:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD024303CEB2
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F80829D291;
	Sat, 30 May 2026 19:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Ojmyd5d6"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64416233952
	for <stable@vger.kernel.org>; Sat, 30 May 2026 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780170694; cv=none; b=EIUongsFSuyDB1TLqUHrjarqUFktgWq6mmMQuhT8YCzR8DKW8OABu1Ydex3od86MuK+nHyTAbOpvRa2RmcyOawKGEGpKQV9cWf46TI+6RE7/V4edrN++HNTZpbTgyQBJ86jfyjEsgel/XJG3uZy8YhTiKlurMHr4ahXUbzWdu98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780170694; c=relaxed/simple;
	bh=zXU1bjcXYaqqJeD7XFUHjdIFKMhUsrYPKJBUJM80q18=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qI0fgbWq0B5e4l9l5PA6in2eJrPdB2BnYHzNHOFA2ZFXly4fRiuEy08ipzD7DqQE+PszbjzARUqVZjy1j4EIFmsmAHao+syEyWPZnqvjj+chygTF/ROW772w8+lI/MsBMFxOct7ij/V+SuQ7xbuRjAcKyV7nB77eFe25g732evg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Ojmyd5d6; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=aauNtjMGBqIyEKuSe/QutO/PoOoUZpL0MWQOPEVrCDw=; b=Ojmyd5d6BYI05nT9MqjkqFK2is
	Te8bmZu28mI6uNqxzlzNr37zIdhJaTx7ZSZjLotBX8cUpZ+CoVrR1zdnHd1m2FNbE5dMExEiqng0y
	Ht/zAUSgg/ABN+46XiTRcgddRVKODbqUnBF2gB+F2KPoPkH/tcSa0Bk01/w0r6oKtUt8qPp28LWPI
	RR4DBjz1ORzwPdDVyFdAsZFcTEDkf2Z1Vf4kUVK4vuxG4tLkbDQ6XoOLvnKZqQryQmLouxefN7UH7
	a1Libotd25mwj5zhrbFjRPhPX+oTF4S+gWWOrWvgWRKB1fEC8uknEGEehHlbmTIEGcx+CHSipGSA+
	dfFkkmXA==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wTPiQ-00AMOG-2B; Sat, 30 May 2026 21:51:26 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH 0/2] drm/v3d: Fix indirect CSD jobs with zeroed workgroups
Date: Sat, 30 May 2026 16:51:17 -0300
Message-Id: <20260530-v3d-fix-indirect-csd-v1-0-15533948663f@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7bkENLfpKdBBday8WGhKIf086D
 sxMhUyJKcM6VEhUOPMVO8hxAHfaeBCy7wxKKCO0NFgmj4Ff5Og5kXvQZY9mEcYFJayeLfT0TtS
 df7vtrX0yJEfVZgAAAA==
X-Change-ID: 20260516-v3d-fix-indirect-csd-6806cf20a57a
To: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=855; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=zXU1bjcXYaqqJeD7XFUHjdIFKMhUsrYPKJBUJM80q18=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqGz+7klskmc5fCZ52jor3eaBpbvXBF4RZn21J+
 aQRFv9bcnuJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCahs/uwAKCRA/8w6Kdoj6
 qnIhB/4t/SucvdSEbumbp6H10PBvW3kfv10CLN9C9mzlOaGKdo+tSEDZjv4WSrMHuqUcalaIc5w
 GVdbd1NyVhbXZmFU2qOsRr7kDhvLxefBwXCPG5/IaZVWYtkOfWzCcjoUS9KX0oUjeJKslE+1kYd
 DmnHdbuf0Xu+rlvzIVoD0ey8Phic+ZsgGDIqrgYfq//t9UAjxAPrYzYD10sAy8OC303pXeHDnlL
 WjfsqMTvd6+kNOGSuhwbGjYSydcYqjKhGkRuD4i80IY7V4vDl/E1qbMXhbToP2QSyxKDdcD0+hd
 SbfVJQ2+2Q94CRcKYSZioOZSVM9OuTkkdFvwEoG/wY65FeNs
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259288-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[igalia.com:-];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mcanal@igalia.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_SPAM(0.00)[0.014];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,igalia.com:mid]
X-Rspamd-Queue-Id: D5E336131D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Indirect CSD lets userspace defer the workgroup counts to a GPU buffer
that is only filled at runtime, so the counts are unknown at submission
time and can legitimately turn out to be zero.

However, exercing this case exposed two issues in the CSD path.

  1. Virtual address leaks when the indirect CSD has zeroed workgroups.

  2. CSD jobs with zeroed workgroups shouldn't be submitted to hardware.

This series intends to address both issues.

Best regards,
- Maíra

---
Maíra Canal (2):
      drm/v3d: Fix vaddr leak when indirect CSD has zeroed workgroups
      drm/v3d: Skip CSD when it has zeroed workgroups

 drivers/gpu/drm/v3d/v3d_sched.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
---
base-commit: 5ab62dd3687bcc2cc542b99385aabac5c996db6f
change-id: 20260516-v3d-fix-indirect-csd-6806cf20a57a


