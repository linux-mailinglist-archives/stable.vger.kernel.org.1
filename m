Return-Path: <stable+bounces-254346-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFHtOMGbFWryWgcAu9opvQ
	(envelope-from <stable+bounces-254346-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:10:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 438825D618D
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF4DA324BBFC
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972683CC7C6;
	Tue, 26 May 2026 13:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="VF1KadyI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="elYBKXJy"
X-Original-To: stable@vger.kernel.org
Received: from fout-c3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED37357CE8;
	Tue, 26 May 2026 13:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779800727; cv=none; b=umv/C2+nQOnG8b4GEOi6MG8Vb2hv4495U/FqJh5ufSt0doRDQBFWSRLKazO86ch6mtwR0EaBmTTsek7VOqiaNgSipIz9F0TqkbAt0vSDZP/q1gCG7asyfL4inlLKYKRPjcLzQ5ktyVyafhm5aM8Mpf8GjaCl6i7Btk+K+qMvg8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779800727; c=relaxed/simple;
	bh=o8SwNUysqqOMKVR4AVp5RvJEZPV0nQ2WqI3xepDKDH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQ6Aq2do7WuZMcPvsopzcWby/KaWCeXdafIesSVQsoHFdMRNUgidjJ1kNQNrOVP5yT7nE328VmCYtncP2qXALdxNKj11MoHIsk5uqgc7koZqOmay7LeI8YbeIuavvgS/l1jDC5WG8hyeWYbnei4oDI2MFApFXji65uuCKVKQa6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=VF1KadyI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=elYBKXJy; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 50A181D00133;
	Tue, 26 May 2026 09:05:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 26 May 2026 09:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1779800722; x=
	1779887122; bh=r95UsN6POXemku+UEWA0RutW8+SVMPDyy6AAJkPaa+o=; b=V
	F1KadyIFrAFs18cLg3xDeNj8DTmmqk/dwKRM8dgHcgEn8PKLRNcGqwBPbJXRcqQd
	KBVdnbfmW37mrwQXmOo9IMC2j+flCz5JR7jiGBc3rzss4ocIZwGbhC86NaCFkBqf
	fpM4voOh+LyZGaBgaef8gCn2GTYSbcrQTTMsi9l2pOKDujX1LR9qeoH10DPufiOA
	UIOMwu/yTu3hh8M/Q5QhU6Pq21HabEiCMDo/vrXBQACK5I/Wjszb6PH0I9G8IJZL
	+nwfYJuq1uhOr54POH0Ib0brEydYBovCLasy4BL+4DAS2Fu9ezE6nxW8nXFRUYiH
	80tbQbIjSESTqvMPu73fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1779800722; x=1779887122; bh=r
	95UsN6POXemku+UEWA0RutW8+SVMPDyy6AAJkPaa+o=; b=elYBKXJyH+kc564cM
	gSloRSWrjMp8j9e53ZdkrSnzIB6uLXipuMkEvAVkMwrcjMrSicTeUpHj52Sjt9eC
	K1v400OgBdqB6e1YGrU+5vz3RMtayny3XVlqhO03ZsMNTQRCQLvWNlmqNA6Py5IX
	YENhi+aFTDYPEMyP49STAgtVZfT/juPGCQtjDM1MlafZr3uwzkGSwdcrZSmgp/4+
	st4NRwt9GH8Sx9sG8gaIGREoK0XHe/djFxhvYqVsAtPTKcuEmwewK+3k0l2VyfSG
	a0ia4zbHlfxCBF1piKMH79emsuwn9RetK0fJdyQ8dR6p1Za6B8FRStMU0l5C9Tn4
	f61nA==
X-ME-Sender: <xms:kZoVajpZPxHSQdfnkxClwxMW3UQSkq9u61eyDVQW_AHDk_ZcKa1pmw>
    <xme:kZoVauvQS7e3qLndYdXgBQt6d3IInM9JyUKwOTFMH72WJFd5InPD-yi9KbqK3Rejp
    Xa6WTzkzRAndKbx3aEPcM9RtoLKcXYAq63cU7Mx8jsn3MFKIUmoezE>
X-ME-Received: <xmr:kZoVajLrJsJ_s6OvtPGQytQLgHx0u9WWmz-9jvWQfptXAPLoFiFCLca7aNSKZg>
X-ME-Proxy-Cause: dmFkZTGhhOzazjqDbg84kXmGQIriAJ7A5ZgfZ0KyuPxd944l9VDoz0auYhNa1nywHIJo+A
    1950kHkKTkQx9lnfSbZcx/S8Mcmt8P0l8Wb8fN0f+wGCwnBkoWy9vl20eCC3tZZX+sH7av
    Dlxe1oS29Zt+/zoZFzy+yh5aDbHDzc3iUaHQ8s1Xon6Q6ulUL8z0cPYFRnxsd9cUuaOOeC
    grd5OyNgyo2h51fT3APjemmY7PM1ZW9p43vVXIU5xFLcMabfv/O6RwCJbL3XPnw5Oz6kjj
    h/H6ZW2FJischjgbFlb1Y+t4mjYQn8Uqjf0DstcwPvag6qa0D5BtHhYNV9zEgkVoBIpvlo
    i28QZ3xpuMeXkG9Vo0bwb0QNEzHuzfMOai+QEeiDGLl0K7ZTiv6YICoJ4SHacwXkuePeN7
    r78GLR0pW7mJoP9mv/y78Jxzi+EC/jBx5wAG6ygsuZlgXZYVWgbUSsbWfWQnjCeQrbw7qr
    AIpgRyPKxu2MXhtXDmQwFKFE5SgLyyTyiI0IcHS0ZGprqwj+wV3hSqdL8JLbZUdOZlYUVW
    s4W3dUFc2Up2R4BE6+/kRMIUPJwIMit82TsK0X37VG6bQsilv5FrMfL7vpkUPl7SzhT1Mg
    D1FM9brZTa9uvb7rhT2NDTubSOHN5pgdmYEzm1XL6vPT9sAi73w3kw6YefRg
X-ME-Proxy: <xmx:kZoVaklW0yJGKg4RzKy276Q0fKITmOIo0e8sVjv9ChzSV7Zt2tQBXQ>
    <xmx:kZoVaroOHqtTCvgTcF8zG1jOYMcetoQdQpRjePQyHpngNHoIOo8XxA>
    <xmx:kZoVauD5wya-Xu04ooHva_LN2HyV_VwgA3aFK-1jX5-zI-Q_pq_2yQ>
    <xmx:kZoVaqb8NFm-uYnuQ2siyhj-maCH1Ymp8hdrwZEbthzqHmT7xFEtlg>
    <xmx:kpoVaikBJxWpCMY4NBoAOstsmk39XR43rel7l_SliLwG5mn-7tzfYBc3>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 09:05:21 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: akpm@linux-foundation.org,
	rppt@kernel.org,
	peterx@redhat.com,
	david@kernel.org
Cc: ljs@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	Liam.Howlett@oracle.com,
	ziy@nvidia.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	seanjc@google.com,
	pbonzini@redhat.com,
	jthoughton@google.com,
	aarcange@redhat.com,
	sj@kernel.org,
	usama.arif@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kvm@vger.kernel.org,
	kernel-team@meta.com,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	stable@vger.kernel.org,
	Sashiko AI review <sashiko-bot@kernel.org>
Subject: [PATCH v5 02/18] mm/huge_memory: preserve pmd_swp_uffd_wp on device-private PMD downgrade
Date: Tue, 26 May 2026 14:04:50 +0100
Message-ID: <20260526130509.2748441-3-kirill@shutemov.name>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526130509.2748441-1-kirill@shutemov.name>
References: <20260526130509.2748441-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[shutemov.name:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[shutemov.name];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254346-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kirill@shutemov.name,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[shutemov.name:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim,shutemov.name:mid,shutemov.name:dkim]
X-Rspamd-Queue-Id: 438825D618D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

change_non_present_huge_pmd() rewrites a writable device-private PMD
swap entry into a readable one without carrying pmd_swp_uffd_wp()
across. The PTE-level change_softleaf_pte() does this correctly;
mirror that here, matching what copy_huge_pmd() does for the fork
path. Without the carry, a plain mprotect() over a UFFD_WP-marked
device-private THP strips the bit and the trap is bypassed on
swap-in.

Fixes: 368076f52ebe ("mm/huge_memory: add device-private THP support to PMD operations")
Cc: stable@vger.kernel.org
Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
---
 mm/huge_memory.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 42b86e8ab7c0..b7c895b1d366 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2663,6 +2663,8 @@ static void change_non_present_huge_pmd(struct mm_struct *mm,
 	} else if (softleaf_is_device_private_write(entry)) {
 		entry = make_readable_device_private_entry(swp_offset(entry));
 		newpmd = swp_entry_to_pmd(entry);
+		if (pmd_swp_uffd_wp(*pmd))
+			newpmd = pmd_swp_mkuffd_wp(newpmd);
 	} else {
 		newpmd = *pmd;
 	}
-- 
2.54.0


