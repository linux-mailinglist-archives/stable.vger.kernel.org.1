Return-Path: <stable+bounces-254347-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPFqGd2bFWr9WgcAu9opvQ
	(envelope-from <stable+bounces-254347-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:10:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 099CD5D61B2
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7999833156A2
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809F23D9684;
	Tue, 26 May 2026 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="0Ff9KK5j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tq/IS1vr"
X-Original-To: stable@vger.kernel.org
Received: from fout-c3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819803B5851;
	Tue, 26 May 2026 13:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779800732; cv=none; b=SlQoq0c/rXkzMqmpDsMFGkZ93ElYNAxfUX+7NOtaXm0r6XJoJjwvnQvqQtXMnAWRyuNKWoQaFNeuWmsaVwuv1Co/ctlRHuUyDg/oks0wol7AnnAZ36s2bYhuhMn/tr0+v2YWLKkP2OPam8YO6SIyIgXOhv1FeWZGK8pmJwlEQxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779800732; c=relaxed/simple;
	bh=Aa7q+R70Rfhw3FjOKqvALHtYuktvZ/CCoA0n1h5+WIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AgJLBRQl/NsVktuL/f6JQNzIXAD/70pDtipgqlsnxxuTbsr7ds8L018XEiiSyx4zJ+Gjt1LcZ4x863NqFjKTT/ug1kak9rZBVt2CwHOuah9CeOiwlIgZ2Dr2kMnvM4E3T2K5tGVUJ93OPVsafd8iVBiqxme1S3c7luEGtCKSueA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=0Ff9KK5j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tq/IS1vr; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 2F3B21D00136;
	Tue, 26 May 2026 09:05:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 26 May 2026 09:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1779800728; x=
	1779887128; bh=d2ZWqfxA3Xfz/rbOUTC3r3TWiQNsEFUYd9kcAPigHDw=; b=0
	Ff9KK5jJKOUb5d5liGmK5GatF06r44Cqioot76R60wyzD6cRAD9/2HeBNut4ujaS
	W2GEl7DHhCjn8SBl/Dn6IbsDf4fSsHiupW3zsAt5y9KaIeeHUnfOqmmLs0dzHQb8
	yL9NJAglP41B0KecJ+SN+MfhSvYG4i9QPP3veMLaNRJfz37Sh+iS8tKHxlIPt/hL
	A+cyp3Kk1xHYrHaRf2aXafzfSUwaXt8hRTLnPcg7WbTUgF2duU5kcAv1cLaj/9eV
	CjFtsjAN7yiEmkjsXhREstaGOz0oslu8fN7kdgdBdH476fKfBBPzOJlonrF4pXtc
	JXN+Tlf+125HctylqWzKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1779800728; x=1779887128; bh=d
	2ZWqfxA3Xfz/rbOUTC3r3TWiQNsEFUYd9kcAPigHDw=; b=tq/IS1vr8K9Xqtgj6
	hGGWy8M5burQAAJFH0YCT/nT8ovMNG44HRzh7iF94TumMePIZjhnQ9atwHGP95+9
	nqghS1a/qL1/ZjK3nYEkBHTjgoiTbvZIZso0UG6072OAlxVDRruJju1BcoG8YpyZ
	dB4UBVsdSDUTXxvWYSMCooVaa7PZNa7N/BJ0Rs4NecmDKCGkyVOeaBvZtEFWVk1Q
	zmCdFDFh80V9ORlxHE9nXmEvposv+o2wjQ47XNKuGb0zhKToto8OgiF2ztuI+gJx
	kq34Bb2JpQ3H/T06Lm3G4uXduOFgb7/ocjDXERCSVuM0d6VPGGezmHEFf6nphESi
	RGPEw==
X-ME-Sender: <xms:l5oVapEQREyqAyXgzoj3JyV5dF2GevI2K5JILv8N-4gc2CsvJq1pQw>
    <xme:l5oVagDv5TZKe5_ReejPF2kKd3CE_TkVhpvPFhIhldDhk5TPRsTUdGQoD6pICqGt4
    wXiJ7yf-0m0fb2Q5ow3BtxD_cmhFSQuOJZHX7fxMpTeF0X_oCI8yyM>
X-ME-Received: <xmr:l5oVaulzn0VZWjMJbqWO8LAHaWnW7N0hrBVADFWDiOFhSqJRNbyptKvI5DLUjA>
X-ME-Proxy-Cause: dmFkZTGorQpjKAi1i8ZG7iYIJOmPXyYX16Wn66HfpfZJJwBiL8IODTEb3YekzvnSBlbsM/
    X6SQ7ppixGZbLDOnnWP3soza/h36vxVDnsrC4ARxk4Fv4Yxwdlz6XfYgV6aVIhmCAkL7S2
    rg8LxWrTzJxnWF5mIcscGivOVXfPKYpE0f6/jiO1NUStm2Yrejvp+NeLpIjMig9ai5xjSZ
    OfcKIZ2RBZ3qxjzIlRdeUOJIM3gZ80hy7RrJ61riH0RZeVqDEJKO9QmnDrbe2YL9kG6jXf
    jJ57EekWZW19wOy8aabwVWOCaUr0TBZVdRGF4CNgIjxmzTTbsnitPoPbwOXnU30/TzlgQz
    7FtKYR4dZi54wHrYQVhUER00pFq5LStKwSFXwPOG3Vf4ECuBo0m+ZCs6GaATfLv3YR0/oD
    R/sn8lj3ySJEA70rOZ/5ulxtvgnYy6+kbWK2YY//GIXDgADn4aMyrp88Y8k+uMKX0saJGq
    qt3NscLpQPqSHFguy4RerDH2D82jpyQb6UPZ8hb6IW+AmShC0tv1FRp0N1uBKIYOn1nuCV
    s/Yekbapt/tmMvawu6RTGFOLqbNk2Q/wwDfdoXQaxq+L4uhAvleHvWgGWyEoMxhGto9LOt
    oqn1gmDacXcYL+l5QGABeMXIy2A5N/lw6eH5WqqBzP5ZbOBIU61XrbkURIUQ
X-ME-Proxy: <xmx:l5oVau6lQilRttxZLL3uPbR3nLw57vq_HW7684_SfTJiErlDA5RR2Q>
    <xmx:l5oValvXSNLcUdpaUel8hQtUQxL-wNBBiyW9N5f338N-fa1aIUd2xg>
    <xmx:l5oVauXyRY2JceNxqFJ-Lezmgdp3BUB0tvC1RImipaPZxMZ_fBi6Cw>
    <xmx:l5oVamEw9tYFanWfa7Ydl0EulvM7hoEpA7IQuQ480dBJBlBYznfFwg>
    <xmx:mJoVaptHxgo0EELYExcTw1ohvypCC79cMadcpJiGv83nk-jqMvlhgVhu>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 09:05:27 -0400 (EDT)
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
	stable@vger.kernel.org
Subject: [PATCH v5 04/18] mm: skip out-of-range bits in mk_vma_flags()
Date: Tue, 26 May 2026 14:04:52 +0100
Message-ID: <20260526130509.2748441-5-kirill@shutemov.name>
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
	TAGGED_FROM(0.00)[bounces-254347-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
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
X-Rspamd-Queue-Id: 099CD5D61B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

vma_flags_t is one unsigned long on 32-bit -- NUM_VMA_FLAG_BITS ==
BITS_PER_LONG by design, so VM_xxx-declared bits sit in the first
word and hit the single-long fast path. But the bit enum declares
some bits unconditionally above BITS_PER_LONG (VMA_UFFD_MINOR_BIT
== 41 today, with VM_UFFD_MINOR == VM_NONE on 32-bit so no VMA
actually carries the bit).

Passing such a bit to mk_vma_flags() goes through __set_bit(41,
&one_long) and writes one word past the end. The compiler folds
the OOB store with wraparound (1UL << (41 % 32) == bit 9) into
the first word. Bit 9 is already in __VMA_UFFD_FLAGS so the mask
happens to come out right today, but any high-numbered bit whose
mod-BITS_PER_LONG position is otherwise unused would silently OR
an extra bit into the mask.

Add VMA_NO_BIT and have DECLARE_VMA_BIT() resolve any bitnum out
of range to it. vma_flags_set_flag() drops negative bit values.
The ternary collapses at compile time, the runtime check folds
away when the bit is in range, and the common path is unchanged.

Bits declared in the enum are now safe to pass to mk_vma_flags()
regardless of arch.

Fixes: 9ea35a25d51b ("mm: introduce VMA flags bitmap type")
Cc: stable@vger.kernel.org
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
---
 include/linux/mm.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0f2612a70fb1..71b11945e4fc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -286,8 +286,17 @@ extern unsigned int kobjsize(const void *objp);
  */
 typedef int __bitwise vma_flag_t;
 
-#define DECLARE_VMA_BIT(name, bitnum) \
-	VMA_ ## name ## _BIT = ((__force vma_flag_t)bitnum)
+/*
+ * VMA_NO_BIT means "no bit"; mk_vma_flags() skips it. DECLARE_VMA_BIT()
+ * below uses it for any bit number that doesn't fit in the bitmap, so
+ * callers don't need to track which bits are valid on the current build.
+ */
+#define VMA_NO_BIT	((__force vma_flag_t)-1)
+
+#define DECLARE_VMA_BIT(name, bitnum)					\
+	VMA_ ## name ## _BIT = (((bitnum) < NUM_VMA_FLAG_BITS) ?	\
+				((__force vma_flag_t)(bitnum)) :	\
+				VMA_NO_BIT)
 #define DECLARE_VMA_BIT_ALIAS(name, aliased) \
 	VMA_ ## name ## _BIT = (VMA_ ## aliased ## _BIT)
 enum {
@@ -1081,6 +1090,8 @@ static __always_inline void vma_flags_set_flag(vma_flags_t *flags,
 {
 	unsigned long *bitmap = flags->__vma_flags;
 
+	if ((__force int)bit < 0)
+		return;
 	__set_bit((__force int)bit, bitmap);
 }
 
-- 
2.54.0


