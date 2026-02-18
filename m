Return-Path: <stable+bounces-217209-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIImCpo1lWnfNAIAu9opvQ
	(envelope-from <stable+bounces-217209-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 04:44:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE01152E22
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 04:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 144BC30091FF
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 03:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F112827AC21;
	Wed, 18 Feb 2026 03:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="TbiXrP/2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E75242D7B
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 03:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771386260; cv=none; b=GiMCn2oChaOdKT4EfzgvF4jxaoHdsPQsqhAnLr1EkRhyZYdClfpjlzcHNWIAqHSTD611btMf3w3oy67JqYo3/FZegQTWpFrGiBjMETbGnBWtXzidDuEZvuyL4nTpacDJrlE5w6gGAPdAYO4JR3rITU3rlVqttbzMTADO5de5uRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771386260; c=relaxed/simple;
	bh=mdEuzxMYPGwd8CNs/UMZJUUnZdwHDwlyCJsLSOvLg9U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZFYpkqyI4iKFim7qa7wZf7io2hLoirQDLNxdJzojLO9RVaEFyHVU1r4M9B2SzvqwJ32cAhwFoEZucG36Ctz+p91j52tH0uRc8x9JmkWlEvJSgYo8GYvEkPBl1ozVW8AVn1668bzXvDgUxNM0+aJg8DkdVg10aRF3SWingXXHQVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=TbiXrP/2; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35658757f68so2158685a91.3
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 19:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1771386259; x=1771991059; darn=vger.kernel.org;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OizJYsHUor2RnnhJFFaJDcXjClQ0nP/mCZL/njlniiQ=;
        b=TbiXrP/2dzTZ0ANHdiIgAmrFiYHOpZHg0V9TVaZ8hlNQSTa9aAqmAg1oRbE0pVi2/O
         Y19nSJ28F1DR+96d8UTDN1uV5ABsrq9lchdt2VWGSwV8bH+dMIqncFH/f9ZAQMm3JWzQ
         rtT50ZiC308gK+fvRG7TCBFw3FN+H9rUukmKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771386259; x=1771991059;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OizJYsHUor2RnnhJFFaJDcXjClQ0nP/mCZL/njlniiQ=;
        b=tz86ULb9082ZxBuhqmkxusAP2255d4CaR6eJexRLtsu6Ia8Oq+hNrgLMIOlREiAJQ8
         TmTBU0KETMW1PwDCpYEWjQvpUx9+R0HDZNbQ2Gv+8+CH7CABtAhQAP2PRlnUGsXHOEjX
         wJ0+Y59RoKXQljwrqGfnmUYFXELpT4tTrEqdhnMMqCwydu8X1OqLIKhxmJ/E7lHs87/6
         JC+ocOOUzCZ8NsokRtsnOBvyHMmePDqB0FIa9gzH2m3lYxHApWsWtIYz9lydv5Bn4f0G
         gF1Bl9rhYs8knpkobhUHNc7kZRBVp0zozxMCsx9m+PJkNlssjm73R6BT4jf1Qeia+No9
         IUsg==
X-Forwarded-Encrypted: i=1; AJvYcCVou4sTCbonwZanGCCWV36laMqZT5lgnKxa6q/ZHaI2zqhsKMkT82dmogyswAZ90PxrT9pyMes=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAhXG3GJAOB5GF0tMkFhb+knElOaEfCBe+QJTjVUMeogeUekLd
	JMjGCqticvXBqy/JYMcuOZRk9GseG7TeV/WSKBT+yMCPbxWeFiQgelerDXoiAHV6+JE/Diw5YeH
	d1v7+PKpxPg==
X-Gm-Gg: AZuq6aI3/M3X27l+v+s0YQjwnlXVJ4lFdX2TswmaaEM5HdWgVSL2kSVDBxLd4fvrv0b
	a/5itmBNSkd34QHX0o1aEXxllC8Wjo+X13SViaq4tcEaqvSEt/yYo1dKWr08VdFVoInfTtNsnES
	bcJ1nfSlckrBbjnocU25WHOI0TQdKklaD/zfK6z/dxEUdnjSDGjeiycysjvKpRWiym9GVf7XCBX
	4DeFUMB3WDMfVtyElEL8JMPhAnG33HwPR+hiD1URWr9VB2qP/Hwv/Ll1aT7XB6pP3yiWGqzm5XI
	cER6oDISkyun9faUAa/yC0VUupxW+mxAJ478fBafynfENnWATUgPiQ6Sogc/rdXI9Cl7Xqjn+DU
	mOSZkQWVRrWUf9Gz1o4l14Rif3dsp14eSQX73AhkL0PWcEQ40uenbIXfu5pttVdnSMaxPB2fVC6
	gaamskBzcIfFDUjbjRllj/
X-Received: by 2002:a17:90b:3d50:b0:354:ad98:7d1c with SMTP id 98e67ed59e1d1-35844a354c4mr11528304a91.11.1771386259008;
        Tue, 17 Feb 2026 19:44:19 -0800 (PST)
Received: from localhost ([175.139.248.66])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35887899158sm388475a91.5.2026.02.17.19.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 19:44:17 -0800 (PST)
Date: Wed, 18 Feb 2026 11:44:17 +0800
From: Chris Down <chris@chrisdown.name>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, kernel-team@fb.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/2] mm/huge_memory: fix move_pages_huge_pmd() for huge zero
 pages
Message-ID: <aZU1kTOLcrr-Z371@chrisdown.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.15 (2b349c5e) (2025-10-02)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chrisdown.name,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[chrisdown.name:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[chrisdown.name:+];
	TAGGED_FROM(0.00)[bounces-217209-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chris@chrisdown.name,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4EE01152E22
X-Rspamd-Action: no action

Two fixes for the huge zero page path in move_pages_huge_pmd()
(UFFDIO_MOVE).

Patch 1 fixes a use of NULL folio introduced by the folio_mk_pmd()
conversion in commit e3981db444a0 ("mm: add folio_mk_pmd()").
mk_huge_pmd(src_page, ...) with folio_mk_pmd(src_folio, ...) in the huge
zero page branch where src_folio is explicitly NULL. With
SPARSEMEM_VMEMMAP this silently produces a PMD with a bogus PFN, on
other memory models it is a NULL deref.

Patch 2 adds the missing pmd_mkspecial() call that was omitted when
commit d82d09e48219 ("mm/huge_memory: mark PMD mappings of the huge zero
folio special") marked huge zero folio PMD mappings as special. Without
it, vm_normal_page_pmd() on CONFIG_ARCH_HAS_PTE_SPECIAL architectures
does not recognise the moved huge zero page as special, incorrectly
treating it as a normal page and corrupting its refcount.

Chris Down (2):
  mm/huge_memory: Fix use of NULL folio in move_pages_huge_pmd()
  mm/huge_memory: Mark moved huge zero page PMD as special

 mm/huge_memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.51.2


