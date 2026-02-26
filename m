Return-Path: <stable+bounces-219780-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAMgBdQRoGnbfQQAu9opvQ
	(envelope-from <stable+bounces-219780-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 10:26:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D5E1A358E
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 10:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7298D300E395
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 09:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E121F3B87;
	Thu, 26 Feb 2026 09:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="pCUdZKT3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACEB39A807
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 09:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772097712; cv=none; b=eSi4SULkf8U8vBLqKAQHFQDtkJq0Ckb1zxA6ePJA9mN82uxoN3N84KfSsUdMPy+W5jDT22eTvBhWcngg0mZrTCiQtO1aL9pz1Gf+BEL3rODaniRy1JzTkUlFrupYqeXr7vKU+0mlq7HFl9fYt6+zxRdvre24sWFuVmRVa+WQeMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772097712; c=relaxed/simple;
	bh=xFmSiTtF7VcBXcNyOqiPcdSVZdfRx2Ym9rHJPtx/YVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TW7POyC0Eed5HU7AF/a2C+9U1Tpg7UZWfHHcBWhFTN1BAKyMzPRnOYWYTlpquWY4WW03Cz/BF3dbaqaudWIMuRfzAVB+3Ccq/WOtGtat5ovPXyub0qAYe4U7c04fl47yjLz2GvGHwh2/BJi+l48sVkd57iCHDqB1yWoCvodfywA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=pCUdZKT3; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4398f8e2837so531902f8f.1
        for <stable@vger.kernel.org>; Thu, 26 Feb 2026 01:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1772097710; x=1772702510; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFmSiTtF7VcBXcNyOqiPcdSVZdfRx2Ym9rHJPtx/YVs=;
        b=pCUdZKT38mAgnOxx4g9bfc/V6CO2gqncYpkYXohnOqZdOEYUvCQs4aAta/KO8GFaDs
         /fDC8afRTkgneK2Fzo9i7zvsCJmuhTHFPgx7jbaNET1GZ8bMPcSK85vIPYxkLOzCFOel
         h+Gz9w2J1uro68fMMUCEqf7IGFqz8lOv2cRHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772097710; x=1772702510;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xFmSiTtF7VcBXcNyOqiPcdSVZdfRx2Ym9rHJPtx/YVs=;
        b=fof3Rw84urrPMZeQ+k5gvO+kI9Rb9Teq2v2np3sxf3OznXo6yywAYpETgGWnxKDhSI
         Bdy7nt6lML8/lyxBPJKTelD6fsX7MGpk9Ax1kD/sx0Yjv8YmYVVtjysvKGpagA6gNtlT
         8+UrgrcEb9Nt4Hj2ZEbrmwAm3u8oDgHVdEnK/w2/zAPSW3bqBF+vdKl7+hPt7lIm8B9+
         PiX1X+d8xxBMbFzlyAKhnCK9LQkZs8uev6nW0haapBHlDY0kKTmXreAlaNt5vP2XIBHy
         JdXTFaWT0kt/Yh9v4wEdSVNUpGlLaWhqi0NpyaC+6ARbl1R5y1X1P0V4EJ8DTqY5Vxqs
         KvKw==
X-Forwarded-Encrypted: i=1; AJvYcCV+wqhqYVGfqTwBO22n/fU/72DN8cHhOe2YuLRL9+EaUy5LEaeR+lDE9RpRzNmX2QmjE7gTPHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyekVy8du9ZKJWqY4S/EZfvh6ckxO2Ag6sHNBelhNbyI8oJCfD
	0ahanTRa6qVALAWlHfj5BjkCKf/bFuokwkS6gEv5VkUrhRwVvwNFXGFbD7UfRRaKyjE=
X-Gm-Gg: ATEYQzzdCsFU3oMtzNd34RebzUZocuzKFNTAuyuzWbU7QM/Lynx92ZXWSGyKl10i2AX
	5EQRjQS1iXNJtU7b+iEOVU632rNiukpRfECYz/qDuVJP69KAwAtc1gvSeyoV9fR3kyTl06wC00J
	2xmOx9/IQgVHynRjctmkMD6D6plxZRlsA8nT9/7ggUVWehSJze+2sIOAbq4ZMtwhoKEAhSeqez4
	iSF0ykPMMnyfz1OSgKIkdA4R93Phd5ybv1m7CSMjm9y+8EpFbdbR1rt2+6CaSeZl/s5CB7XoNmn
	BZEj+e+omjW3efiIEDjfCUjRdjRI72EEIfBMeEvaJYWZ5vDKjIF75ry/lqPQ/idw8fiF5ZH5PHq
	FPr8PhOm/ajTxxJW2ZttiS+Y/3KgRUtznrpy9RndAt8iOSNL7srss80YFVYWBs+WgZmryNM3k6A
	GQaplGdPP3CcJRpEpBm1c=
X-Received: by 2002:a05:6000:2283:b0:431:32f:314d with SMTP id ffacd0b85a97d-4396f165655mr34727737f8f.25.1772097709632;
        Thu, 26 Feb 2026 01:21:49 -0800 (PST)
Received: from localhost ([85.255.236.51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d4cc81sm39379192f8f.26.2026.02.26.01.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 01:21:49 -0800 (PST)
Date: Thu, 26 Feb 2026 17:21:45 +0800
From: Chris Down <chris@chrisdown.name>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>, kernel-team@fb.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/huge_memory: Fix use of NULL folio in
 move_pages_huge_pmd()
Message-ID: <aaAQqS4uHm7Th5lq@chrisdown.name>
References: <aZU1vSmn5aF8xvJj@chrisdown.name>
 <0b653dcd-842b-4360-bc1c-8fe779efbc23@kernel.org>
 <7da49940-e1a4-4018-9db1-208411598e77@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <7da49940-e1a4-4018-9db1-208411598e77@kernel.org>
User-Agent: Mutt/2.2.15 (2b349c5e) (2025-10-02)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chrisdown.name,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[chrisdown.name:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[chrisdown.name:+];
	TAGGED_FROM(0.00)[bounces-219780-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chris@chrisdown.name,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chrisdown.name:mid,chrisdown.name:dkim]
X-Rspamd-Queue-Id: 68D5E1A358E
X-Rspamd-Action: no action

David Hildenbrand (Arm) writes:
>Chris, do you have time to follow up, or should I look into it? The
>issue looks quite bad, so we should tackle it ASAP.

Thanks for the poke, I will send v2 today.

