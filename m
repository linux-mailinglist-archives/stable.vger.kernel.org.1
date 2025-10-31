Return-Path: <stable+bounces-191773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3420CC22F8D
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 03:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D483634F48E
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 02:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F422749C5;
	Fri, 31 Oct 2025 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VY7YDhSm"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9262737E4
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 02:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761877199; cv=none; b=MXAVOf/O5H9tS2MkFAbUmNsCOkJn+P7m93dTP8va8qR/fLX2HcfdSBGTSTNsUpYrIl1TdG5OYRgS0kBxvj3B/TQGuZuxLJQiJOSSoGphgYTHAUS75cWBoxnFgcjAMEwYu7PtIxmCsV/03GUnaUIAyDtR+Y8BF+dlRxKg34V2uEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761877199; c=relaxed/simple;
	bh=3zQ1xqV8A42MGAiFtuedptKR3TjX9ZAKsBp2ihtBCQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvTRIXdsCK1Yp2FRvyH/uesvtf1S4Nkft+cZedyEsqLXANRvx+y45yltLZJujeX1/ueH3FLTc71m1pIp9b/7JNVGTwWSJr+OHRTMm2cohosQwRdK+yg4t+We8+TEw93EKiSpGoiqQFIbXzvPJPnFSbQmywkxjvMKWNs0hsEdDzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VY7YDhSm; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso3089161a12.0
        for <stable@vger.kernel.org>; Thu, 30 Oct 2025 19:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761877196; x=1762481996; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAuHBkzBsMSaj0Gbuvv+XkhIsngSwsrTuvil52QriUA=;
        b=VY7YDhSmVcypp67EV2qpwLqG4zSbBoPf6AFPi2vaevt/ezLVlrBGpC8f/++EoKxyWG
         UGMbUNGm4hO3K98AEHLY7PvrFUVhfVK9T7sPoIwp2+FIFY9FaObD6f/aqb2k9FeEurhY
         dS6cGTE/lQnWCeiyVAgGo2sSwDFrUDZhxTdHo1/PRAMBD1HCqoH8ScT+3fRcMh+0gBYE
         7CaOF1RL7rVC+7+jrHZ31ZtbQY6fTazRT2j2rvAVS7+cCO6BabC3tOM7pW1p/l6PhxvG
         zb1logAH/2v3YguO97LhFa4DSM8SdvINEILuDixMpdSdrLCOqi1jOrjK+miIIckgcOI3
         TgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761877196; x=1762481996;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nAuHBkzBsMSaj0Gbuvv+XkhIsngSwsrTuvil52QriUA=;
        b=D0f96n1sIOncmJ36P3I9mjK0cB2YAShCNMaw9eRpl5vr6U4KyfHioHjbFDpp5klSpb
         wPhGxpapOMeHiVYnvVbVYArFz/J5kEXuizC5amyIOJpeXJTAtwj17sCqKjJ0ssjQKvuL
         Rtr0+wu2LwqqZDu5QdBXGLEC0+5Ty88Z1hA6HARChMedZY/lnjEmaG7W4fl64yXOAAOU
         wq/cmPvK3ZzQpFuQt3mdqFbftMYRzWKkOx0J9foC/uyyeYgc99dO8uuFUBsoeRBywMsg
         QPu05TqDCSpl6l4qljBEWI8fxFi6+ho8zA3NyQdmyckuihnqYhP3eylDFLIjYUnXJJcY
         Jg5g==
X-Forwarded-Encrypted: i=1; AJvYcCUJmHrO9+1Xq6OTBv3QAw2/1xL1FD8B/yRh3QFp4pe5ljEJ4rC6ZkGcEmpqmI/lLCyCkHzOUOw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzudu6r2Bcs228VXPTU+aRZBlS8nJ8SPpA88NK4L6tfr8NW9mxD
	34RgQ9rFADVbRjZGOOhwDd63Mcb/MiYhgqvZjgYR6XHt+iZ2Kkd54w+e
X-Gm-Gg: ASbGncuWGE9RzjAlY9c3XhH91B7TugDF8Ft4wFAE29yJB4bxgoTERiP+4JpfynyNIE2
	l1llE3JTY4Tw3kOk+2SoyWVIGoqaUxnnjZZpq0P28bJ0U/kwyAvVQRF1ULvLTbjgkKwpcvgxSHD
	bsKCwYMo6gsA74YclfDTt1Gv8/Tfp9ZcrcIqs87ByL9/LtEBkCAIBKvPUG1Sdvq3XXMG2iAw28h
	BI2o6EqnbBI3ZCop48QmlrIFSDfqKtP3D8abT4RiLBvYhXBbzBVjXelsUVbaQkuETJjuiCW8Pit
	skaMnNH5oWvFshmQS2JpjEpwMioEoyZ1JmkjYT+xiPoD4CvCvnRQt6aAY2FpNW6x0PJbkP+P6YM
	zMRtN+D0NO3Y7H5XQNTlm0qKG3K+yVFnxQ23vmwZ2gov4J5PFmyZ7dNEaCrT0QF/vUaVK7PrXIl
	PWNJcaMPuqTw==
X-Google-Smtp-Source: AGHT+IEcH4kOFzp6/56rakvTEjeBVzfv6qBiWaY3eKFtuXFG29gDskvq3YaNRtp/ukRJ/0KfRNrsvg==
X-Received: by 2002:a05:6402:1445:b0:63c:4f1e:6d7a with SMTP id 4fb4d7f45d1cf-640770127d6mr1311349a12.19.1761877196183;
        Thu, 30 Oct 2025 19:19:56 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6407b427a23sm488415a12.21.2025.10.30.19.19.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Oct 2025 19:19:55 -0700 (PDT)
Date: Fri, 31 Oct 2025 02:19:54 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zi Yan <ziy@nvidia.com>
Cc: linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com,
	kernel@pankajraghav.com, akpm@linux-foundation.org,
	mcgrof@kernel.org, nao.horiguchi@gmail.com,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Yang Shi <shy828301@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] mm/huge_memory: preserve PG_has_hwpoisoned if a folio
 is split to >0 order
Message-ID: <20251031021954.ba2pymy2hjvgzohf@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251023030521.473097-1-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023030521.473097-1-ziy@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Oct 22, 2025 at 11:05:21PM -0400, Zi Yan wrote:
>folio split clears PG_has_hwpoisoned, but the flag should be preserved in
>after-split folios containing pages with PG_hwpoisoned flag if the folio is
>split to >0 order folios. Scan all pages in a to-be-split folio to
>determine which after-split folios need the flag.
>
>An alternatives is to change PG_has_hwpoisoned to PG_maybe_hwpoisoned to
>avoid the scan and set it on all after-split folios, but resulting false
>positive has undesirable negative impact. To remove false positive, caller
>of folio_test_has_hwpoisoned() and folio_contain_hwpoisoned_page() needs to
>do the scan. That might be causing a hassle for current and future callers
>and more costly than doing the scan in the split code. More details are
>discussed in [1].
>
>This issue can be exposed via:
>1. splitting a has_hwpoisoned folio to >0 order from debugfs interface;
>2. truncating part of a has_hwpoisoned folio in
>   truncate_inode_partial_folio().
>
>And later accesses to a hwpoisoned page could be possible due to the
>missing has_hwpoisoned folio flag. This will lead to MCE errors.
>
>Link: https://lore.kernel.org/all/CAHbLzkoOZm0PXxE9qwtF4gKR=cpRXrSrJ9V9Pm2DJexs985q4g@mail.gmail.com/ [1]
>Fixes: c010d47f107f ("mm: thp: split huge page to any lower order pages")
>Cc: stable@vger.kernel.org
>Signed-off-by: Zi Yan <ziy@nvidia.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

