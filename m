Return-Path: <stable+bounces-268000-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hcX0GszXOmqEIQgAu9opvQ
	(envelope-from <stable+bounces-268000-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 21:00:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F316B991C
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 21:00:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=bombadil.20210309 header.b=A46V19S6;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268000-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268000-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB49A303F29D
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 19:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A17F37C907;
	Tue, 23 Jun 2026 19:00:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6225E208D0;
	Tue, 23 Jun 2026 19:00:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782241209; cv=none; b=FTWlpdkoUh+TOG1bv/wB4YQNhW9rvDwOG4XQUcc9AmUMMSs8Ukk09oqLN3ZDijMDr0TZQ2lZ4N4X0BELyCZw9sCLTDhXcftg+NMj2U2Oec2B/zkomh4k809aGzwp1Iiut9CFGJjgEdyHWEckBe4+nX6oUPatgkc/qxw+KE70BMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782241209; c=relaxed/simple;
	bh=JVjFuSKn3aFlRO2Q8/2E9ZSMlkBFFd6H9fKy00BxQRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L/kP20cNdjgE8QTBjqy77iGjRNXbIMvs3s5ka3yWYBJ+mCz2UdwFqJazwOWygz3hgqaORqckoGjD29bl+EDzZCCyuToBC1bI7ilpi8DSXIRzy+UMEJU6eOnMI5XSFBF7tqzcKFfK8S4+pd/A6wCcZX1GfTihECfV32y1aNn3z20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A46V19S6; arc=none smtp.client-ip=198.137.202.133
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=NIYs76V2E3I8ofE5ECYosMQo1WgSs68DjhqIn/YRT1U=; b=A46V19S6sav/MEWuy5UNNVIC89
	W/F2f830iFwrbnwGQb4ozWrVg0NELhmCVxgY3tymv8ecEkHaybOmKPWviryProptFnX7wNhsrW+rh
	7eybeOgUIVRR/pZ17tQlEtNzFLYMyHqECxrWUjiPTA9OyaPdgevchhYwlB7uybWg4S2Ijoa7nypdH
	pu2ilxpJIiF1w4fr5nDtsCA+GXvWRzSlyeRYbdvHLYduD0FvCcI780R7Khznfl4Se0g4+0qDQ5bJz
	luki0afj/HZqr+NUIQ4dPToaREuxM10VA5Ukc9Fbyd5hc5oxv+C6v3/ARZ16PLj7slLIFvi7CAaRC
	ib8ljBxA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc6Lv-00000006mIR-1Bkp;
	Tue, 23 Jun 2026 19:00:07 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	driver-core@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] kernel-doc: xforms: support __SYSFS_FUNCTION_ALTERNATIVE()
Date: Tue, 23 Jun 2026 12:00:04 -0700
Message-ID: <20260623190006.406571-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268000-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:rdunlap@infradead.org,m:linux@weissschuh.net,m:rafael@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:gregkh@linuxfoundation.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-doc@vger.kernel.org,m:mchehab@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rdunlap@infradead.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,weissschuh.net:email,infradead.org:dkim,infradead.org:email,infradead.org:mid,infradead.org:from_mime,linux.dev:email,lwn.net:email,linuxfoundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B6F316B991C

Add support for __SYSFS_FUNCTION_ALTERNATIVE() to create a union of its
members (as though CONFIG_CFI is unset).

Fixes these docs build warnings:

WARNING: include/linux/device.h:117 Invalid param: __SYSFS_FUNCTION_ALTERNATIVE( ssize_t (*show)(struct device *dev, struct device_attribute *attr, char *buf)
WARNING: include/linux/device.h:117 struct member '__SYSFS_FUNCTION_ALTERNATIVE( ssize_t (*show' not described in 'device_attribute'
WARNING: include/linux/device.h:117 Invalid param: __SYSFS_FUNCTION_ALTERNATIVE( ssize_t (*store)(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
WARNING: include/linux/device.h:117 struct member '__SYSFS_FUNCTION_ALTERNATIVE( ssize_t (*store' not described in 'device_attribute'

Fixes: 434506b86a6c ("driver core: Allow the constification of device attributes")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Thomas Weißschuh <linux@weissschuh.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: driver-core@lists.linux.dev
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: stable@vger.kernel.org

 tools/lib/python/kdoc/xforms_lists.py |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20260619.orig/tools/lib/python/kdoc/xforms_lists.py
+++ linux-next-20260619/tools/lib/python/kdoc/xforms_lists.py
@@ -49,6 +49,7 @@ class CTransforms:
         (CMatch("DEFINE_DMA_UNMAP_ADDR"), r"dma_addr_t \1"),
         (CMatch("DEFINE_DMA_UNMAP_LEN"), r"__u32 \1"),
         (CMatch("VIRTIO_DECLARE_FEATURES"), r"union { u64 \1; u64 \1_array[VIRTIO_FEATURES_U64S]; }"),
+        (CMatch("__SYSFS_FUNCTION_ALTERNATIVE"), r"union { \1+ }"),
         (CMatch("__attribute__"), ""),
 
         #

