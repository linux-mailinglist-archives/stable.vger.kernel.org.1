Return-Path: <stable+bounces-233271-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FonG/nH0GkMAAcAu9opvQ
	(envelope-from <stable+bounces-233271-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 10:12:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0039939A594
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 10:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 17A183006B77
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 08:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D20D3A4537;
	Sat,  4 Apr 2026 08:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rd1b+Tqv"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE2C3A4525
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 08:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775290358; cv=none; b=s1pZkaytIaPnFC5B/gowSN1KvVOn3iMidERzSf3pPdVucpmh4wz4CWVxxgD1zZN6CLD2tElBCUcJfzqyq/SXcnaJuJJgcxuNWC/FmYU/YdYCSdVQs3iSdlzH7jEBLisGYloXyug+8TS17ne+WuSFxnoqQ4IRZNvChOmNBtv9VfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775290358; c=relaxed/simple;
	bh=ORnUqdz4ubAqnYzzzFqNVLdeVP03R9sWIIGWUXs1rWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jod7WAPhuNcHg5d90sN+rnf4O2VAewOefdJIDGZJcTyrjetKpLcDKXDslTZgFpYapljQIFvigE4HjszzXiD2C2wiBGyZstT5Lu0Y0No+0iZ4g3wur9OQ97hxeFv66AYnHriWpeNLCa3zWl+yHr6cqC4gBhe37xKmJmtVZ7XMdIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rd1b+Tqv; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43cfbd17589so1957745f8f.0
        for <stable@vger.kernel.org>; Sat, 04 Apr 2026 01:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775290355; x=1775895155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nJ34TCzJzKWinCWURHGvYIN+UCxz91gBSkks4GEORFE=;
        b=rd1b+TqvkMLVhEcpCp6ZXIkgIyZQaB661NvuJq5Tt9oYnSYnm6cdctxJV7I+QESFGu
         JYsBzFSxSjd8UpSQjMZ25d7DMvBVtSwf6jGiSTUTJPAw+SoXxroD+8XbgowhV3hRzlSa
         aFJ89sNZ4g7s3BgYew0sEVlj/yczBDIo16k6mPybKbkQSW2XQ65xl8iQMH2c+PLcoUQw
         wXsjy27PoU0qr5jivYypi1NBxzvbLF6RI6zwMGtOzBJB6XDLV0m7nUsBC1dk16XaC0uT
         d+GxlxnbwWOeuIfySx4F9KbLs8z4wK0AQ3vNlzjn2ITTzMfr9JvsYDgWPT91XjyfER6a
         gJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775290355; x=1775895155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJ34TCzJzKWinCWURHGvYIN+UCxz91gBSkks4GEORFE=;
        b=jMVWL5WrO4+CfegJvUeq2DDsfnGwWIh6UbuMZW2ehNjXCI3E/CZRNBcQxh5aBRyNDq
         cT72pEADGR4OBo+9W9rTAp7zydwPnYIz8d7MIGZIsu5EAkg/wDNGwOAJqKZMXulBmcng
         2WM6MV24w1Utxv1YEJD0W6hwySeSJ2Bem6BCRUatxwvotVcwXY2PenOKDy8H0AoaZuAn
         WKX1cvBymlevrSFQX8wfb7O2d00gUCcJPtzoKtXIFOnCreOrFFzrqK7X6GQ3vfHS1g6o
         F0kTILmGaz+RnIF052FfgNB+UYjsD59NHtybsIeaHUzjuPogpIcklVM6mGrFIVp4c6UC
         5TyQ==
X-Gm-Message-State: AOJu0Yz/kGa2UryFRGxoy6e/dNp0uU/WxIpmOiu0wanVHPsskFCUZqh8
	Kbb8nYAhtFHzeQg64gYnL+e5tXqlERWoYQkXcovdMviNLgJhhgpgKPN1vMbmOJ1q
X-Gm-Gg: AeBDieuhB5vl5fVuSCGfPdJZSDLZz8tSV93m5LMIqGo+aqJkZYn+AqiJyoxW3wkItLP
	HFb7HlJNoF61B983JV67sMOqvfsNvFv50pTVk2XC78CJX1TAJPd+rEpIg91Rshpa8UwAIAJx66y
	tY12GdgKdzjvYdHzozNHwWgdLZDJ3YAfyfhHlwUoojII2AVl16WZlc3Hmc4OfFOyALf2fQBTtuJ
	T9GZ7eIzVDA/8undTvWdMUpkJxB7vDRt2jAEqU/3B9YCpif8QvGzh95vX7VGobR7t+Onwuhebqo
	EmtvURz6I/oqM54QR0qNBsUTDoBVwVKbB5lUgP4JsBPnqvd7nImDkoTmGErbIy3yKPxF6drFE2a
	oJTB8WlgHqm7pcY0mz/fYi7SzWvS6srpez8BV7oqGD8eoTU30no9KhSoVxQ8ZCvpOiogjB1pExO
	920hI9kAkwjiup6n200jVqo9UmuPxUq7rSXXlrN15FyF5CmR3dqobzgSXled9mmcqXXPywyDxCF
	jA4pWEAnzXcOPbHwXQqQHiZZ0cFizeCiEFp3tjOj/6GpXvXQG3pjbSeCBYR5/vxc6hCoMRWcGKz
	IDFW9G8BfommzMeAkVpnDKVROttrzvN8FJTPwM1jvyU=
X-Received: by 2002:a05:600c:818c:b0:488:7784:d06 with SMTP id 5b1f17b1804b1-488997dcc53mr81526355e9.31.1775290354900;
        Sat, 04 Apr 2026 01:12:34 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00359acd79a267583c.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:359a:cd79:a267:583c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488980e7a29sm51206325e9.4.2026.04.04.01.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 01:12:34 -0700 (PDT)
Date: Sat, 4 Apr 2026 10:12:32 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.12 3/6] selftests/bpf: Test invariants on JSLT
 crossing sign
Message-ID: <8391b533f7f9876aadc8ae1bf9915516db575cd9.1775289842.git.paul.chaignon@gmail.com>
References: <cover.1775289842.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1775289842.git.paul.chaignon@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,gmail.com,suse.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-233271-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0039939A594
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[ Upstream commit f96841bbf4a1ee4ed0336ba192a01278fdea6383 ]

The improvement of the u64/s64 range refinement fixed the invariant
violation that was happening on this test for BPF_JSLT when crossing the
sign boundary.

After this patch, we have one test remaining with a known invariant
violation. It's the same test as fixed here but for 32 bits ranges.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Link: https://lore.kernel.org/r/ad046fb0016428f1a33c3b81617aabf31b51183f.1753695655.git.paul.chaignon@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_bounds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index fe3e2b326c6b..3924b1d1421b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1028,7 +1028,7 @@ l0_%=:	r0 = 0;						\
 SEC("xdp")
 __description("bound check with JMP_JSLT for crossing 64-bit signed boundary")
 __success __retval(0)
-__flag(!BPF_F_TEST_REG_INVARIANTS) /* known invariants violation */
+__flag(BPF_F_TEST_REG_INVARIANTS)
 __naked void crossing_64_bit_signed_boundary_2(void)
 {
 	asm volatile ("					\
-- 
2.43.0


