Return-Path: <stable+bounces-183242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE13BB76C0
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 17:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE05F3C57D3
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 15:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7598C28D82A;
	Fri,  3 Oct 2025 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="UJBzJmLg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ATdM4+O4"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D912A1F9F73;
	Fri,  3 Oct 2025 15:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759507098; cv=none; b=Z5sD2RC8v/8XGFMFcUVErYdEoteInhPoaJw56+rhsDLnDXhoWuU4J2ueUFlvcU3V//+nVxO2FWgAGLPIT2Ua/TRXfuxmOfL30t/Kk2NPNhEA91UqcVV5CYROr9zgPMoQ1/LxXRzqHdH4kxSll1REJLvmvwVdaJfWXEitL1hZ9A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759507098; c=relaxed/simple;
	bh=o9GexXsN59HkOJdQWN3aCnb+c+019kYVNtAh306GMt0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Muvo9sXOypM8IuVR2VHDg/yGpuK4bo8aLOllHrAxjSY2xEo0rHH72ka9IqNT7WeFfk5iBsrBcJ59ai217CvE46yeXCch1Hln9zGYTrC/X7r/0rk9lPyo3udbs4ShcGmWkTta1P3bMZsZzGwHL5COPe+TikjzhRoVQRGG8Z8wAbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=UJBzJmLg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ATdM4+O4; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D4A5414001CD;
	Fri,  3 Oct 2025 11:58:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 03 Oct 2025 11:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1759507094; x=1759593494; bh=ylh0+79jh+
	5mpu0rkNzXh0nSiVx9FUZ19dIaYAtmCkQ=; b=UJBzJmLgw+FRSbvaBJ+EjBjXba
	rglrv7Zecm9n6giqAjtF5D1XTb2jaS+ll/0+swxIOpJEuvLiPj6WmTyKEy/WLnnR
	mzGavQzRibKtQFiYP8EGGzip5Ak0rCmEPOxgpAqjVLEMqSu9yxpt5X5l5Zom6hjM
	nU23b0wVu7rMwc56OsronBG65Rc+rUcL7S35yoF0TaLJS2wAqnPwR1kD95DrkVXt
	eFkRBl+6dP9VUlOCcMbJApU6olp0+YQzYGZ5tQ91ter6Osnt5B5Aq7v2rD6h4iy0
	wARIISpmH67/riYXvAeq9jO04+F0C5UYMKOTPSJLqzQ2q3XyWUrE+3t5nStw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759507094; x=1759593494; bh=ylh0+79jh+5mpu0rkNzXh0nSiVx9FUZ19dI
	aYAtmCkQ=; b=ATdM4+O4C/v7iL6osVt5k7JYJQlXHk+1NJir24QEPmRGAJOQRp5
	k6hGBAQsWgTMnybbtr21T1Xh+C0Lde8z6hCkgZlPPmHSt2B5EsYUnhPikWsg1ffR
	m1L95YEWQ5meKkgiFXSO1OFmwKUPuVkJHPHpe3Xqf9fYV+D0UF32FJ2ofjg7mJBw
	I7g5PkiComP72q5hwJ5ytA77ikilrSSE29JlFIirr56KD4rquqh/DUnNJ69Fl/pI
	E0KgMpholkKlSjzxeCc6kQzHGeaE77+0hAcv3wWQAdteD9jMOP/jcEfnGdbOm0IC
	Iwh4GLUDRMEo0DpVwF0OAO3jGLdMnhbz1CA==
X-ME-Sender: <xms:lfLfaI2chILEw53jXpxx5R1s1OVdWI9x4bM8SwCfB-OVQfiNCQqtoQ>
    <xme:lfLfaNdqTtZg4Ug1wwVOlGEuNTpSGcwbslFiiDACNpH8sOyWLeIDKSn1-X9lgPFNn
    ERS2V1rJ5ghdbIwqlurRPUoUIuandC3eZxYdft5D5Ww-5C5OwygVIE>
X-ME-Received: <xmr:lfLfaHBHW1BN39WVR32eF_BUy-_NZ0k1k1YYkNI-vH3eUDxhkE6aE5BCefGkZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekleefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefmihhrhihlucfuhhhu
    thhsvghmrghuuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrg
    htthgvrhhnpeetffduudehveejfedugeektddtvedthfehfeehteffleetieevhedvfeeg
    tdehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepudehpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnug
    grthhiohhnrdhorhhgpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrdgtohhmpdhr
    tghpthhtoheplhhorhgvnhiiohdrshhtohgrkhgvshesohhrrggtlhgvrdgtohhmpdhrtg
    hpthhtoheplhhirghmrdhhohiflhgvthhtsehorhgrtghlvgdrtghomhdprhgtphhtthho
    pehvsggrsghkrgesshhushgvrdgtiidprhgtphhtthhopehrphhptheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepshhurhgvnhgssehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehmhhhotghkohesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqmhhmsehkvh
    grtghkrdhorhhg
X-ME-Proxy: <xmx:lfLfaM8us08O5kadM5KWraGec6JOwJhvJK8-TyyBLtkYgaoxy4xFQQ>
    <xmx:lfLfaDrtVyht5daTJ5vFnV33G2l_q98DjH_ghIEPLemZSLy3wE_Xng>
    <xmx:lfLfaOGQtF3UhGXG54DibiYKDEhYsiWofdMrMPseH3KpCavW0juYbQ>
    <xmx:lfLfaP9FWy5vS5B4H3ULDMIuKG4T88hEpjZVXbYmI9-LgUM5cc7mZA>
    <xmx:lvLfaP4SUwVoXDHfcC5-eR-MdGX4p2WOJ4AXyl2zEmPkQRQhDpNKfvph>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Oct 2025 11:58:13 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kiryl Shutsemau <kas@kernel.org>,
	stable@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] mm/mmap: Fix fsnotify_mmap_perm() call in vm_mmap_pgoff()
Date: Fri,  3 Oct 2025 16:58:04 +0100
Message-ID: <20251003155804.1571242-1-kirill@shutemov.name>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kiryl Shutsemau <kas@kernel.org>

vm_mmap_pgoff() includes a fsnotify call that allows for pre-content
hooks on mmap().

The fsnotify_mmap_perm() function takes, among other arguments, an
offset in the file in the form of loff_t. However, vm_mmap_pgoff() has
file offset in the form of pgoff. This offset needs to be converted
before being passed to fsnotify_mmap_perm().

The conversion from pgoff to loff_t is incorrect. The pgoff value needs
to be shifted left by PAGE_SHIFT to obtain loff_t, not right.

This issue was identified through code inspection.

Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Fixes: 066e053fe208 ("fsnotify: add pre-content hooks on mmap()")
Cc: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>
---
 mm/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index f814e6a59ab1..52a667157264 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -573,7 +573,7 @@ unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
 
 	ret = security_mmap_file(file, prot, flag);
 	if (!ret)
-		ret = fsnotify_mmap_perm(file, prot, pgoff >> PAGE_SHIFT, len);
+		ret = fsnotify_mmap_perm(file, prot, pgoff << PAGE_SHIFT, len);
 	if (!ret) {
 		if (mmap_write_lock_killable(mm))
 			return -EINTR;
-- 
2.50.1


