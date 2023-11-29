Return-Path: <stable+bounces-3120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3171A7FCECF
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 07:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60B841C21057
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 06:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A193CD269;
	Wed, 29 Nov 2023 06:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6jGTLFX"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E542695;
	Tue, 28 Nov 2023 22:05:20 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-77896da2118so369918285a.1;
        Tue, 28 Nov 2023 22:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701237920; x=1701842720; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FX4qlget3IBa2/cwRBGrPsNi/y6/7lBLgyUhVLo/vNE=;
        b=G6jGTLFXWGz3aRoZmV2aE13ElrqOdYKAcmWGv00pjf3E4ZPBqX8Yf1Wvtxe3/UGm+y
         NG/VOLvApYb4NGbpJUy8Ta3X8HkVHApu0dWVoNA9oM0IkxDfpmsdGIE621rU3WW/WAeN
         M4VCXwp/HXv0how8Zq2jrrEuk+KZsFlhhhCMoRTBUUrQKgnB4MbdM5mLt0b8KlgU+ZXD
         s6kLM/jhvs4gPLz7neJsfCpX1OvR2R5VM3cwRIccdkBBV1VizWbHXPcglGJzw1QaBs36
         vLGatwUghVDyLjAcLtBxF2ODTINCi63yZFTaEuL/AVGDq+wHwKYSXJX2y9VrnRCmv55s
         V/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701237920; x=1701842720;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FX4qlget3IBa2/cwRBGrPsNi/y6/7lBLgyUhVLo/vNE=;
        b=qxii795uSr6A18aAXg4kGGh9RVhnjDd0wQgZUnpJjK2Un0jKTCmzP1pl7BA1E6+mjP
         Ikiw0WnjPZWaI82thzqz+CodAAR9TNJlacQlJqb4HWJaDkhV+Soq6R1iqP00oignshwR
         ZGuOuX/WL5mkFAoySBPYfjYsU3GrDRTl/NSIDj5uWXQVsEJemrUAfPUAxBPRIKU3IHIb
         2uJRADEMlJ5HlnIdIO2QCOw723p5YpHjKmkJsIrkl1h1CcYVq5xm/Up13E1R5XiR75M3
         Ho45pYnFBLk3WaljyuuZaQYBPmwAnnBAC1IWP7eLzPQ3T1w+7tEdZYZecKhirtCsLLqW
         cLSA==
X-Gm-Message-State: AOJu0Ywiv1adD1hnCUGn5dp74UVJk/5b1V77o2jGgE5jZz4I2/Rulu/P
	oP/y1suczKmw4NY2JgM75cLT2Gqji6qV
X-Google-Smtp-Source: AGHT+IFWM+hY9oZWl8KBivLwRzOspoWHPC9BiBlpbBRmd0/dHcJMLcTzSDdQJw/D66UpDUBzL23Klw==
X-Received: by 2002:a0c:fa89:0:b0:67a:f7f:318d with SMTP id o9-20020a0cfa89000000b0067a0f7f318dmr18441414qvn.49.1701237919604;
        Tue, 28 Nov 2023 22:05:19 -0800 (PST)
Received: from n191-129-154.byted.org ([130.44.212.103])
        by smtp.gmail.com with ESMTPSA id r10-20020a0cf80a000000b0067a0e04076fsm5410676qvn.17.2023.11.28.22.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 22:05:19 -0800 (PST)
Date: Wed, 29 Nov 2023 06:05:17 +0000
From: Peilin Ye <yepeilin.cs@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable-commits@vger.kernel.org, peilin.ye@bytedance.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Cong Wang <cong.wang@bytedance.com>, yepeilin.cs@gmail.com,
	stable@vger.kernel.org
Subject: Re: Patch "bpf: Fix dev's rx stats for bpf_redirect_peer traffic"
 has been added to the 6.6-stable tree
Message-ID: <20231129060508.GA17429@n191-129-154.byted.org>
References: <20231129025247.890789-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129025247.890789-1-sashal@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

+Cc: Cong Wang <cong.wang@bytedance.com>

Hi all,

On Tue, Nov 28, 2023 at 09:52:46PM -0500, Sasha Levin wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     bpf: Fix dev's rx stats for bpf_redirect_peer traffic
> 
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      bpf-fix-dev-s-rx-stats-for-bpf_redirect_peer-traffic.patch
> and it can be found in the queue-6.6 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Seems like only patch 1, 2 and 5 in this [1] series are selected?  We
also need patch 4, upstream commit 6f2684bf2b44 ("veth: Use tstats
per-CPU traffic counters").  Otherwise the fix won't work, and the code
will be wrong [2] .

We should've included a "Depends on patch..." note for stable in the
commit message.

Thanks,
Peilin Ye

[1] https://lore.kernel.org/all/170050562585.4532.1588179408610417971.git-patchwork-notify@kernel.org/
[2] veth still uses @lstats, but patch 5 makes skb_do_redirect() update
    it as @tstats.


