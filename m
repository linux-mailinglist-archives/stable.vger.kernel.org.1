Return-Path: <stable+bounces-273490-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DOG1NQWLU2r0bgMAu9opvQ
	(envelope-from <stable+bounces-273490-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 14:39:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C55A744AD7
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 14:39:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gourry.net header.s=google header.b=fcXnFl9q;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273490-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273490-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 485E43010D9F
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 12:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84213A9D9A;
	Sun, 12 Jul 2026 12:39:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398442BE033
	for <stable@vger.kernel.org>; Sun, 12 Jul 2026 12:39:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783859962; cv=none; b=Bg15EuylPems5HriPAEDuRikbyPGAzr9VFWaWFfCyxxpj1ZkFw66AA+woxTkqGwW4Jand36nS7SFLUuq2hQFtm+24UXtGqx2SfsBK6Va0XxhRj6pKTEqDKXgpTJz7hTdnPlwIjwUTlyQJs8ZzqcnJRC6/XPFqzsLowtaut2RAWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783859962; c=relaxed/simple;
	bh=+dukaAvtSE5JGlWs02PRixrf4baPDWdMwCbWnYTgd3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIsYqCxxlpPo6QdWA3nBt0SvltX2tnaVmtHaHEWTKMtEI9b6s/ukXOkyOxpSw/X8wCzCfpEIyF7oWx0dSnUtIx3OYlomboZI4T0WNNOieMdkftahy7HjggIK1pwAchf8WcndwAjJUj1/qUwUGBoxVuAKJDT9oUh6y1spf6J+izc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=fcXnFl9q; arc=none smtp.client-ip=209.85.160.176
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51bfbe05683so14989901cf.2
        for <stable@vger.kernel.org>; Sun, 12 Jul 2026 05:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783859959; x=1784464759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DpBJeAespB/ecG7leQANvH1JBf2dPPB4qbmO+Bd4+ZY=;
        b=fcXnFl9qvzafPG6HTkI95Pu5jbJlG/e1JNVtwJK62TLE3ksaZMinXAKTqWe2EDbPy9
         qELrJfMx3dI5bgF9KKaSpX8Ohy9tIGRvBB9ffhEXjxlL5uPJ6Kby2OTFUXNDNh6UM3EG
         yYi865f16NaAeiIj5D5S6xXpV5EdkfVGZGrZuHa7MCTFV1ghHiOSRd9zJ6zIOkZC11UC
         H/+Ki26od/LdDfr4iCRVxe4iCks7MYMLq6oF1BR/rUUjdgwB98zVEncFsru5x2ytnLUW
         2BAmXPDsjOFL0guKVO+/7yrPs/HPjP+NEq4TtsAC/cJ89Gb02BuYL6BRVo8r8it9M4pW
         561w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783859959; x=1784464759;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DpBJeAespB/ecG7leQANvH1JBf2dPPB4qbmO+Bd4+ZY=;
        b=GK0IhAIccGOxyT3unb36FHaTzde5+eDesu8hR8sVbb7y1szULvtM+6D1myRRRy9hja
         0AVqhLsixPW8aSfCez9DJESnTexOd38nmnVtHkw60zCp1bD1UtFNs5m6T27BuoT2d/D5
         TAwiR4xkDLg14Yn6zfkPJCzuccdTXMCZ0qPVKI9KRDupJbL5gpyFoYNykSRt2L0u1wET
         dLyEXz14dAwvOmJPIAjf7xOmG7xpp/w/57qjZaEGxO6O+TR9u4IBRg/o74w10PtsB3d2
         206jnXw/jllBsEP8+gJpuYPDKjKsKMy2uqQvYAb7E9Ml5IVT8r6LzVUwUs5cX1lnantz
         k1ZA==
X-Forwarded-Encrypted: i=1; AHgh+RqCAQ54lnP0jnMd+mtGQuuxvoNJymmTkzutTPDJGEKPBJhSlxqxVGBQrzLY5K7aE6hN3yhVqP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKqQDva5UE7NMbLsZUtxV+H4Fp96Zyu1HpcGKO9b4VMn1ZvPQr
	0JGdd3jaSTzDO8fgPiV8msCMWpFgNXt6f5mTVh2AoSzU/7Wg81/+uxspejGtfGtGGNL/QPglnEJ
	Ux5OZ
X-Gm-Gg: AfdE7cn85WQ/HRs8AoyFWqRLHdp5eshXlYWjh6wPWxSh87oIlqqTSXMeytW2kkY2W85
	++mSjG5iuUudRp9+w5f9oCXMkN+zY8G8QyTXCAo96X8sxzTVe4P3u93OLpD2fd0YvgHRy+t20eg
	pBgu0wMB9AxLvgq162iVMNoTPUGgO2Kd2lGS5WvkeHEliUwPiK2XL1B842myNn1LZ2oo8tm1N4J
	/0DmhaNDhMp95tdWgFdWlVBY5redgGiLLIZba9MLNh8svt6/CxhKsYOBP1mlGS37K7UQxsd7aii
	sfIdFzhPrCgFLJfx7c/OZkBFiAz+f+nzbK4MwdgmOS8fmwmjVz2fiIRg4SuxqSLO5PbAa7KVQ92
	iILkCZtDQDRCXE1uyHFE5+lCtrRqSN/yqjF/isU9D7sPry98RXKgLFIEkz1/afTCZWbBx4aBYh1
	4XoVXu2uJs0Kig4jscOlFFznBYBHnUHA2cLnw7DOMBjpf7FzRFlsfvJWOHmFhjoz7j7U+m
X-Received: by 2002:a05:622a:5c13:b0:51c:9b44:c59e with SMTP id d75a77b69052e-51cbf15fd9emr56444801cf.22.1783859959107;
        Sun, 12 Jul 2026 05:39:19 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd5bbb1e1sm102900876d6.22.2026.07.12.05.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 05:39:18 -0700 (PDT)
Date: Sun, 12 Jul 2026 08:39:13 -0400
From: Gregory Price <gourry@gourry.net>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, apopple@nvidia.com,
	balbirs@nvidia.com, baohua@kernel.org,
	baolin.wang@linux.alibaba.com, byungchul@sk.com, david@kernel.org,
	dev.jain@arm.com, jannh@google.com, joshua.hahnjy@gmail.com,
	lance.yang@linux.dev, liam@infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org,
	matthew.brost@intel.com, npache@redhat.com, rakie.kim@sk.com,
	ryan.roberts@arm.com, vbabka@kernel.org,
	ying.huang@linux.alibaba.com, ziy@nvidia.com,
	shakeel.butt@linux.dev, hannes@cmpxchg.org,
	sashiko-bot <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/3] mm/mempolicy: skip non-present PMDs when queueing
 folios
Message-ID: <alOK8cVLS8FYFGdE@gourry-fedora-PF4VCD3F>
References: <20260710105557.1987433-1-usama.arif@linux.dev>
 <20260710105557.1987433-2-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710105557.1987433-2-usama.arif@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273490-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FORGED_SENDER(0.00)[gourry@gourry.net,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORGED_RECIPIENTS(0.00)[m:usama.arif@linux.dev,m:akpm@linux-foundation.org,m:apopple@nvidia.com,m:balbirs@nvidia.com,m:baohua@kernel.org,m:baolin.wang@linux.alibaba.com,m:byungchul@sk.com,m:david@kernel.org,m:dev.jain@arm.com,m:jannh@google.com,m:joshua.hahnjy@gmail.com,m:lance.yang@linux.dev,m:liam@infradead.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:ljs@kernel.org,m:matthew.brost@intel.com,m:npache@redhat.com,m:rakie.kim@sk.com,m:ryan.roberts@arm.com,m:vbabka@kernel.org,m:ying.huang@linux.alibaba.com,m:ziy@nvidia.com,m:shakeel.butt@linux.dev,m:hannes@cmpxchg.org,m:sashiko-bot@kernel.org,m:stable@vger.kernel.org,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,nvidia.com,kernel.org,linux.alibaba.com,sk.com,arm.com,google.com,gmail.com,linux.dev,infradead.org,vger.kernel.org,kvack.org,intel.com,redhat.com,cmpxchg.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gourry.net:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gourry-fedora-PF4VCD3F:mid,vger.kernel.org:from_smtp,nvidia.com:email,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C55A744AD7

On Fri, Jul 10, 2026 at 03:55:21AM -0700, Usama Arif wrote:
> queue_folios_pmd() is called under pmd_trans_huge_lock(), whose
> pmd_is_huge() check returns true for any non-present, non-none PMD
> softleaf. Passing such a PMD to pmd_folio() treats the softleaf encoding
> as a hardware PFN and can return a bogus folio pointer.
> 
> Mirror queue_folios_pte_range(): handle non-present entries before
> looking up a folio. Keep migration entries counted as failures, but skip
> other non-present PMDs such as device-private entries.
> 
> Potential trigger: an HMM-based GPU driver migrates an anonymous THP
> folio to device memory via migrate_vma_pages(), leaving a device-private
> PMD. Userspace then calls mbind(), migrate_pages() or
> set_mempolicy_home_node() on that range.
> 
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260703173903.3789516-1-usama.arif%40linux.dev?part=6
> Fixes: 368076f52ebe ("mm/huge_memory: add device-private THP support to PMD operations")
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Usama Arif <usama.arif@linux.dev>

Reviewed-by: Gregory Price <gourry@gourry.net>


