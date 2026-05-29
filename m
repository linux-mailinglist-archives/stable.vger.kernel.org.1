Return-Path: <stable+bounces-256674-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLk1GJbNGWqNzAgAu9opvQ
	(envelope-from <stable+bounces-256674-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:32:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D734B606819
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5441310D029
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 17:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA490383C96;
	Fri, 29 May 2026 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTtJGEh7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB6E382291
	for <stable@vger.kernel.org>; Fri, 29 May 2026 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780075456; cv=none; b=SuMFMv7GgyPLutrt1FYtFb0kd4SavzIMTyr7bBoN7m361F3TC2ZkVL/i9ft+ipsIUb5Z9bHQv+esj4EF1tcqX6PgEl4yOL/5qamwubZPwT8ppXcK8wIGzjufEf9bYNSMkolke16rtkzJOupKXuOICCb4weFSZE3+dueVl1hHWw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780075456; c=relaxed/simple;
	bh=lRg8zaWuIQB7a0E/S0QVAKxbOsaItBa8/W7RVnYmB3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBxCZytgyxCYE6KcoIPY60vd5xd+hFLpIQDp1HJGmbTw5bFPwLPSm49CUlAXw3KU/ahHDOnx6k4Wxwr3j+D5Zx7o1HW23C1ndnXFn6jrSkkl4P4UPtajB7uVgHGDSkku2DSbopx7NKLVrHYzdp2+AM6dWciRJCmpKmeTEWXhQVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTtJGEh7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308971F00899;
	Fri, 29 May 2026 17:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780075454;
	bh=fbbpli+hXkiBIhpDsuI5TYzprk7eDfizGvmgjVMK96o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YTtJGEh7Mm/KsO0ad+cS2miLHGEUbr39u5u2xM9Y2h6nuK4ndN/FjmfSHlvrQqKqy
	 DYekQYcuQZpKYD9Ml3nEoHVWaVJxiCL3/7FC2HsSvdCL0+h5jKZs3U4VixQUlD0xC+
	 Nn8UIwuIFl2ymSweMZP8GYYRuS2/K4OchuOOIlUxY58xBxjlZbc88XLYpQBvRxX6ni
	 bv5ZEb0lsX7Dv8yfnRxp2PdKyLROn5vzsCTTU0oVnrlzg/jQroWFamkOu7gRq8GV+c
	 c9PsRwf4abnjdO0fmtbKBelE6GrrKZf7u4Yodc+682Zyca5zJ/aX9K0rYDDBg8zRgJ
	 2nlzus/Po9QSg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 83AC1F4006E;
	Fri, 29 May 2026 13:24:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 29 May 2026 13:24:13 -0400
X-ME-Sender: <xms:vcsZaqgNi-dPsjvESoXOibqniTCH1aaiII-D7KGP0oxGGd6HDGu7WQ>
    <xme:vcsZai93UM9cV5OQKIy0I7pi3TZqp9NDqwiUmMRsDEHXHHaJmZ9w3DJPzJhIsIrup
    vqMpxg98bgDWhNOra06n-5512Amd_91yn1XBBhHGH-zNpcpdH9YY5A>
X-ME-Received: <xmr:vcsZapQCUUf-dC0JuicBhoUlEeTMsSZQuIXx1p-yf6xdyVBGm5eLnGy4RiG4-Q>
X-ME-Proxy-Cause: dmFkZTEZfpMr5/eRRE28w8SXJrP2dhbWJDto6huRdd/cnfVbAAhK4j6L5mXvQtvbZW1Tgn
    qdHjS1xVDGkdt7hr1SYRochmR7yuP2KsuqbhH6HkebbwRdIZkVYqIRv2TfGI9SaQtUiic8
    G8SBlRV6/L2Xtb05bm6QmOQTKoj3b/RGprk0F6woL4YfqntUvh+0D5sL6ruauatQhdAfx4
    sxg873kOfAaKAVmot+PkxhAMe2YWyy/aSlFAam2C/bHdTY9DLsPBVhceLLRJtCvIR2Q+zM
    kaoJA5O2aRPotfcyz8zPVtzBiOjMLe5Pw3NzV/bo4OKaUt+lobJ5eojHQXZMuqCslD6ADP
    cnvxXMLJ+GGO+YsdKG/VtAzip3oPKBED00TGmZboavLxb51m+v659bwaubg2JY1xQjHuTg
    UmCM8Q2oSZdxrvMk3bWtd5KMX1M2Pd6UArm6jSDfw81nsFHKAMQ4fbbfRC+vk9N/Vgfi7V
    oqaul2hByG2eXK5j2n6x3xF395psx+G0RTb5h9LdHo131yNJ4WEPG72PtkjD4woebIeM/+
    o5O0e2DGUKzrXWs7x4haLKZGLWCkhawOH+sDfIB69Q8admleEF9xdNHiVEu2gjwY2cS4MD
    0S3PRQnsWFPiUiwqDqufDTz1neUdguM5GjjW9YxmtF3DDBpmERQbvTJuH76A
X-ME-Proxy: <xmx:vcsZaptuIvMWKVIoDfSSxAt5uSo66EGK16NJygpha6IAG0F3Yet0CQ>
    <xmx:vcsZaj6s24cmbOwqFZUU1reTXtOLJe0YCCi0MiJJrj1ybaEbrm2_6w>
    <xmx:vcsZaoJCJucrLRtgQHE8U_Whi1DSZLTKevFkg4XWEjcOnn5s9I0s2A>
    <xmx:vcsZatQRQvFd3-rD4Ak0Pj9NPRui0PDQ4siQ5W1BH_DXH07U4TRxSw>
    <xmx:vcsZarrmZ9lZy446Zyhoy--4ni-DCz-f0txBjarbHVUvrXTETQHXN6tL>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 May 2026 13:24:11 -0400 (EDT)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	stable@vger.kernel.org,
	Sashiko AI review <sashiko-bot@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Balbir Singh <balbirs@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>
Subject: [PATCH 4/6] mm/huge_memory: preserve pmd_swp_uffd_wp on device-private PMD downgrade
Date: Fri, 29 May 2026 18:23:28 +0100
Message-ID: <20260529172331.356655-5-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529172331.356655-1-kas@kernel.org>
References: <20260529172331.356655-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TAGGED_FROM(0.00)[bounces-256674-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.105.105.114:from];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_NEQ_ENVFROM(0.00)[kas@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,10.202.2.162:received,100.103.45.18:received];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D734B606819
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


