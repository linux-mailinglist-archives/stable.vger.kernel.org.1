Return-Path: <stable+bounces-114005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA4DA29CAD
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 23:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5FDA188853D
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08742116F9;
	Wed,  5 Feb 2025 22:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAgLpTia"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23F6F510
	for <stable@vger.kernel.org>; Wed,  5 Feb 2025 22:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738794475; cv=none; b=gcgdh+uSJqb0LQfA4snqw+x1AqeGnBlM4KpL/7iCwNNYxmGJgvzNhtUv7OCPhC6wOFDf6NS3PnS3okrsxezm5tCBXBxeu1wNbX0urqSlBLs3cHeNVQf8xD8yzhFnu0jo1y31pgK1pRwvTtIM75oxapShneSSCjG+rfUnJXNPIwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738794475; c=relaxed/simple;
	bh=pSWdJfsGucLJrkPUak/tsgAKtAAYG6o3qzLy1voR79A=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rTiuy2IYSha/ore+RAIY+SsSpr6ONqvriUbnU8t3tHv8KUZ68i1CMHUxWuIRo4rsAzUkA+JeS6ZjiYl1PlL7/wUkxOHGkhGq8C1Ei8vIRMn4q22hAltKkMefHhPJQpqK+hxwCuik4ZpdIB5J9Y3LdoANh8QI08NzF0PpCQcllKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAgLpTia; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4361815b96cso1660285e9.1
        for <stable@vger.kernel.org>; Wed, 05 Feb 2025 14:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738794472; x=1739399272; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jz3bxW9BJxlgFXoPDwnr99kbYeKD++5c/1vTuaoPOo=;
        b=XAgLpTiajUjoQvJbwIjEZf4ufjwdK9/L69V06o4/IybX3CmxtzqolzDu0a1W1ngyiA
         j+hmnHxuylt/W/ASKE+BzBGm5BbLEOorrp3ZYuzOtSi/EXRrt3Y5s1eyF4lcrsVRMD0k
         A6xqhOyvYWIYzNTsjn7sQh2SV4NxV0b2WQUJKJq2vGJfARyaJaGgmwqBeoiP+to+cuDr
         E3WbvehIiq6/fq4Cs7WOKS8acha3Dx67FmF5jCvahpwgx09ua6bP8MpvEWrJERn/461N
         ZcngEE/I0zfaYogUN1AOhVD1h5lQAPksol0uZj8q92q4fDlmJszCaDraWy+vOBHJWlDK
         7liw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738794472; x=1739399272;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/jz3bxW9BJxlgFXoPDwnr99kbYeKD++5c/1vTuaoPOo=;
        b=xBNNVo6AKMgr/moh/+J1wU2U6N4jbn0+z4YDr0LlBgUGwKYkAQNWpQqv8cFapkeK8D
         0JrAqWGgnG9z/hMgFMwm6/igxEkVpjAwD7rByE2D9pVl5vr71LfOrXT9IoF4CFD8rS/u
         j8mLSzTacmmpj7WbM0HGZnD8hM4SeBebjNdhen/3gvPTOUVp+nrE7E5v+mmM7djf7llT
         8GaRE5VQNqzCrzuPZsxq7umrjo8O29TSCoEPC0+652kipC0sYbvw/5hZ9LBxHl9e8ZYQ
         6waoGuWti8le2svkdszxGLZP5fu/9zTDX0dDzRt+f1w8ul1pRECcHB7273sLtMetNQON
         F2KA==
X-Forwarded-Encrypted: i=1; AJvYcCXB7Q2P4wf4NSBylh/aAfWAZkSHqmC2JFZpp6aa1XkPH1rSCvkSk7By+mS8CQ6vzHKJmn485vA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT4rQnBOCTM/SlJPYmrsjiE12KvazaL7hmlLQYjrY4mlpPf3tF
	Vk3R8e0Uf3IUVZudi1jmTJN1K9gS7jG+8dmtENcr6vEAZpFfPQcxmu2Rcw==
X-Gm-Gg: ASbGnctjRXNomM6vWVzqbIe7Uy3JqvvAKbhInu+GVlj70mKXiocc1ew+WOk7TaVp4c3
	kax+1w9YCBFjwqhqV5k9oDfW9Lzzz0tF77kuVyYT9RhV/m+qflfxPySm60Qo32Jc/WFtkv2SPWC
	krYwfPyFwsi9+R8NX0Df67oWZxmvwEvTzocTknwPwsnFyXPO/yOWXe4H6cuTvI8/+MOvgPdpfIF
	CyemCqb0NntZokpqAsp+o2O4k1sxIHNdOwUMUJqdwNukWlI/P7fwKd77J+85nCM1/JRbeVhdZvo
	AMRXeBYPYwfXYUuBeYpuf8ncFEetAN06wKXfF1alfTiqPizZDdjJQmXmS9W+fFtRLhcgXvf7nyn
	WGmo=
X-Google-Smtp-Source: AGHT+IFE/wqlYndQ+PU7WjTI1oW32KSRvjgI26rYJ+IoMXU3VDeO11XsmHYCaaQgYogi7VLFtsM7VA==
X-Received: by 2002:a05:600c:1f83:b0:434:fafe:edb with SMTP id 5b1f17b1804b1-4390d561071mr34930965e9.24.1738794471857;
        Wed, 05 Feb 2025 14:27:51 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390db11264sm33703465e9.35.2025.02.05.14.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 14:27:51 -0800 (PST)
Subject: Re: [PATCH 6.12 502/590] net: ethtool: only allow set_rxnfc with rss
 + ring_cookie if driver opts in
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Martin Habets <habetsm.xilinx@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>
References: <20250205134455.220373560@linuxfoundation.org>
 <20250205134514.474132731@linuxfoundation.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <2614b0ce-0b34-03e3-3744-0b91fdd0a32b@gmail.com>
Date: Wed, 5 Feb 2025 22:27:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250205134514.474132731@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 05/02/2025 13:44, Greg Kroah-Hartman wrote:
> 6.12-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> [ Upstream commit 9e43ad7a1edef268acac603e1975c8f50a20d02f ]
> 
> Ethtool ntuple filters with FLOW_RSS were originally defined as adding
>  the base queue ID (ring_cookie) to the value from the indirection table,
>  so that the same table could distribute over more than one set of queues
>  when used by different filters.
> However, some drivers / hardware ignore the ring_cookie, and simply use
>  the indirection table entries as queue IDs directly.  Thus, for drivers
>  which have not opted in by setting ethtool_ops.cap_rss_rxnfc_adds to
>  declare that they support the original (addition) semantics, reject in
>  ethtool_set_rxnfc any filter which combines FLOW_RSS and a nonzero ring.
> (For a ring_cookie of zero, both behaviours are equivalent.)
> Set the cap bit in sfc, as it is known to support this feature.
> 
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> Link: https://patch.msgid.link/cc3da0844083b0e301a33092a6299e4042b65221.1731499022.git.ecree.xilinx@gmail.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Stable-dep-of: 4f5a52adeb1a ("ethtool: Fix set RXNFC command with symmetric RSS hash")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

If you're taking this you probably also want the very recent
2b91cc1214b1 ("ethtool: ntuple: fix rss + ring_cookie check")
which fixes a bug in this patch.

