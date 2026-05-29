Return-Path: <stable+bounces-256672-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPdvBfjMGWqNzAgAu9opvQ
	(envelope-from <stable+bounces-256672-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:29:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1C5606757
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 57C35306EFB5
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 17:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332F438236E;
	Fri, 29 May 2026 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDAzNuE8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19569381AF9
	for <stable@vger.kernel.org>; Fri, 29 May 2026 17:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780075439; cv=none; b=Bew5RISELKaAP4LxX5s2xjvYS7134WdBL/SJcuvwi/Fjb9ALnAtsMFb6nlf7MD+ljgTIvkDiUGSUydKZ15j3vglRUzt8nSiZBgqIVteZj7J3cWUJK0CNiB7JH9Zt1rhxmMnPTHTWFwV//HPlDruV4EA+nrtbti+SZzRDVtdjOZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780075439; c=relaxed/simple;
	bh=YrpAz0FXPAhElqfhnnykZc7iFUIiRTe7Cl78ip7p8Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZTDq5Lgc1UMwKhALncRW2lSKdS4wMwbdhZSIRVw9FErhI0HE3PMwJ+2qvhDXm44HzMOmGFvus8QiraHGL0xPxtAI3JTZQBpqjWALVPvV+zxF5N2Iogl1FI1b838q8AIzfC8FIuTwoqLejOw1HEwX51OrUWV4H87OXAHNw8lQ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDAzNuE8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2031F00893;
	Fri, 29 May 2026 17:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780075438;
	bh=9aQovhm+rAVLhPNqkReF29glHPCC8PiSoid5QftmxW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FDAzNuE84eYzlRj0x6pxTfnojupxhoDw6z5C3Kp/Bqp/PFNITli6eEtysF6NlyGag
	 7OTyYWl9EnSFYHx6FFsGOsf0jqOQfDSI9u+QRh/AnORDxCGpZaEekf6ror5+av9oDq
	 t7HcL7Ki8/EaqfTUdgW3TGyCs3hdWa43bavWu2kuU4V1Q61LABh90ob4QVGARWJ0X2
	 dMeyrFOyanCzT0vi61zEBwum5eI/pVkR0tvg/lZUt2ieazt1NXp9mT4VC+zEbBR+DD
	 IWsdQ8cqy8ssHaJv7fP04Bd4kCRM9h37zPlaYroz9C+lr92r/JESNrmgL/RmDWjDBQ
	 6yrMIaxRDcstQ==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8DF7DF4006D;
	Fri, 29 May 2026 13:23:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 29 May 2026 13:23:56 -0400
X-ME-Sender: <xms:rMsZaq7nsYd1CmD3e8coP_1a-5ve-IU5vN6k58vGFX6pYuyWCzBHFA>
    <xme:rMsZasqUdrKpxoB1b6wdHOuZtJxkllRyewuySjWnxBOO75-L_dWjHsF5Hs-OnkrcR
    4wmbGC1f8mXaGkHf65ClFqGDsFz3jwtaw8am1ZWV0SlA_OLh9ODP8E>
X-ME-Received: <xmr:rMsZaoL1ASf72hiiSY2sUztr2NKeQpY3lvNWDuE7N7EnQYFUnQ118reAu08xHA>
X-ME-Proxy-Cause: dmFkZTEZfpMr5/eRRE28w8SXJrP2dhbWJDto6huRdd/cnfVbAAhK4j6L5mXvQtvbZW1Tgn
    qdHjS1xVDGkdt7hr1SYRochmR7yuP2KsuqbhH6HkebbwRdIZkVYqIRv2TfGI9SaQtUiic8
    G8SBlRV6/L2Xtb05bm6QmOQTKoj3b/RGprk0F6woL4YfqntUvh+0D5sL6ruauatQhdAfx4
    sxg873kOfAaKAVmot+PkxhAMe2YWyy/aSlFAam2C/bHdTY9DLsPBVhceLLRJtCvIR2Q+zM
    kaoJA5O2aRPotfcyz8zPVtzBiOjMLe5Pw3NzV/bo4OKaUt+lobJ5eojHQXZMuqCslD6ATr
    oxy1zzjt2em+zJsRq8POPUsy4CV7PoZHrsAai4kRVafuktEUWzwlzoahhiUOPOMqVMULxU
    OoqIdoLTAo5WAAqArSXoEXRD/SkEHUTjv/Yu5n5CM1khoLP/Zj8mVWMYbGav2f4ELOap51
    nyHTSXHFliTGg10ueqLZO/lhBP77GXxnum5X6OeJxQqeRKO2shHkz87JQ/rk7Rn5rKHBRa
    JzC28BFu5dhwdGTo/2Cd5xWskrDBHDkUH6cTFcJZCSe2jSZeG16EWNT/whd9WMvw6wbbQ8
    BPKfQrAB/lp/adhD0u/Nww3O04VYhY8zwOvVM5i4c504T4ICiektIhpy1pKQ
X-ME-Proxy: <xmx:rMsZapjrWtBnqMfUA6_o-KgFgwqjosrNJxnEOx8DBh42PyVuxplxHw>
    <xmx:rMsZah-fNwK9HhtSZ8yBZBqFfLdTUdxjuzzCUqtfEvNDtY9kG8p9Kg>
    <xmx:rMsZatpQL4F9lYtEqAi2jiV_3ob8HRTUW8H2Mk4rpnKY6OZcrQ78KQ>
    <xmx:rMsZamNSZy4t7I9jqvceOHnqaSbaEBjFcRl5sOHR7B6PNCjhyhe0uw>
    <xmx:rMsZar5jKnhjXEE7Q8iae3ep3jcUgzKRS7BNbuwxXpHqK_CfETLJT0Ju>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 May 2026 13:23:55 -0400 (EDT)
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
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrei Vagin <avagin@gmail.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/6] fs/proc/task_mmu: use huge_page_size() in pagemap_scan_hugetlb_entry()
Date: Fri, 29 May 2026 18:23:26 +0100
Message-ID: <20260529172331.356655-3-kas@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,kernel.org,infradead.org,google.com,suse.de,rere.qmqm.pl,arm.com,arndb.de,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256672-lists,stable=lfdr.de];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c15:e001:75::12fc:5321:from];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kas@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,10.202.2.44:received,10.202.2.162:received,100.103.45.18:received];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0D1C5606757
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The partial-page check compares against HPAGE_SIZE (PMD_SIZE), which
is wrong for gigantic hugetlb hstates (e.g. 1G). The walker hands the
callback a huge_page_size()-sized range, never start + HPAGE_SIZE, so
the comparison always declares it partial and aborts the WP. Compare
against the actual hstate's page size.

Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
Cc: stable@vger.kernel.org
Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
---
 fs/proc/task_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e21a38ac745b..1489c67e88f7 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2960,7 +2960,7 @@ static int pagemap_scan_hugetlb_entry(pte_t *ptep, unsigned long hmask,
 	if (~categories & PAGE_IS_WRITTEN)
 		goto out_unlock;
 
-	if (end != start + HPAGE_SIZE) {
+	if (end != start + huge_page_size(hstate_vma(vma))) {
 		/* Partial HugeTLB page WP isn't possible. */
 		pagemap_scan_backout_range(p, start, end);
 		p->arg.walk_end = start;
-- 
2.54.0


