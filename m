Return-Path: <stable+bounces-163325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAFEB09B2B
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 08:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF0681C42ECD
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 06:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888C91E98FB;
	Fri, 18 Jul 2025 06:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VN1tv6kp"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6464A1E8322
	for <stable@vger.kernel.org>; Fri, 18 Jul 2025 06:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752819207; cv=none; b=p1NSxbfPtc+4aCVxAkhFOonXj1kSgIvJIAr4WFudyN9GySXmRfue0HCxXcs1WEAIN+c2pQsO+BEK+JuGHxfAGffw8Wlvm8h94K4kK7dfuw5YGN52xEQyoxJLfkmsC/x0m93kFl0gnklZ+qib8CVDC9/05B6O7+MNiFYUS61iVNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752819207; c=relaxed/simple;
	bh=dT8dD8otj7B8/N5DzES6KuvGUGVP7eX1fqLflWes/9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXUBg6gUB8eFwD+eE3lc1LsP+PNvEGi93Cj1L9e1rZQuBwUe7zG4RvkfVVxS/qp4PNBujPlOed9xvnNsitBie0t6EqTH+imc6XDB76nAlBVsWokxlKl6+2//UTXj35dNTSAj2weQeWH6SNcQRJVuHpowHiDVEyaQKIrmGNhF+Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VN1tv6kp; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-3a54700a463so949024f8f.1
        for <stable@vger.kernel.org>; Thu, 17 Jul 2025 23:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752819204; x=1753424004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0IlwzZWHdXDZy8rSZ/n+rprYFpUaSyPSB2vYYWvhIK4=;
        b=VN1tv6kpYL09orhwn+Ag6sryHdXf3nHI0wjWJYp2cA6NbKARlAkLpIeijNHc1sJpfH
         hUZkOWJ5F4QaXhRfFljc+JWWVoIMNlnzggkj8y7aq8C0ZH9n27jqv31LrFyhnZN9F0w4
         X/yz25FL6JjgNcJnn7X8hSsMgbyhdziKpM4XomFKN/weP2eFk78oZo19y4lzz0WYy5lg
         fvERmRMFwMcp4k6MSMkCAtJKlJ4uRYSkieDji6AgqLx8H4ffv3FcWhTyxbgfXm5oVG0X
         v/SbnuUNhjLkhYuEcWDElB5W11QYmMWo8YlrqvHx8WIS0TuWmqSVhQB2R5KU1vSNqAv9
         ksHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752819204; x=1753424004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0IlwzZWHdXDZy8rSZ/n+rprYFpUaSyPSB2vYYWvhIK4=;
        b=ESaKEcAS+N9kS0RlSMRYLzt7+aD7jrdZJZaIJnwPma5IQ8fVOIbc5yKbGC3i6ndG6D
         KT1erPyQt2n52shEuNuLmnQn+PO49UAiKucBOBBQcqRy/rXb5vXWZ3uv3k0/h0N3EX4c
         Go28jCN5KjPZTTJwLzZVkPVTrcLc62renZEKdmsj4/OCNSCbntOTgYk8HgtlYaDagxgc
         n7FpUKFFkoHX946dn/hooevpl/3MQn6Kx3XDFfWv3RJLi8jhRbVeGXVik4A5zTiS+xpp
         fEEOBE0A6DwCDFvS97ahpcv7v24jWHM5gJrPK4uyhFNscjw5DhJOycpgLAzgKjSspipo
         iOkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiotlYeHgojjkPWVwjA52XMdFDfdHPd+U+tQKX4k9x+CKKe/PE83bV+hvWBrV7XnbueqZEAoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrrpMHXRT4nSQyjyv4zmc0dVBs1NTnNkRnaRukuW9pYSl8Hc9X
	rof4ez/KI0DVQE8N13RCNyooynNfu8aegIt6eVwB52ollZefKa/iYfD/yt/BNcMI8cU=
X-Gm-Gg: ASbGnct9lnEn0li54UlS8MikBbyzyrresXLctf8kUhMbCf38thPVp6XUCsnPLjiqlZW
	5tUlG3nM+2tq/w4a4eZk7mBHhd3ExtfLsEZie5NB92UmYTC66WQK7Gc/IatzrpHUuh+8S5PsxrP
	LFd7DGvh09GeJvlvGeJZKdTpnl8FLwLiTsyWghGa0DFoLs0bVdSGnolx7UjJ/Q18kJarBHK0cTJ
	vB2UXuQJA+yRs6ksxzt2DilkfqFzK9DVaop9PuPNpzMA42MV5nIkWP79DZDzSJQlCvkxzJQqEL+
	E4/dfUEjXruCpu6IzEymltTNeRYPLHI+Dr4uI07tVXFIZeaP8mGw/JCCWA1kitVuc/V8W7+WN9F
	CiprNkI54CEDiMhovLw==
X-Google-Smtp-Source: AGHT+IGYpCyf/XL+ilOaL8xDgNerjlJC6lG7TWjEG+3HrJvZLStqGqWpJ/kmeZdVkolJuAPRtCM1Fw==
X-Received: by 2002:adf:b651:0:b0:3a5:271e:c684 with SMTP id ffacd0b85a97d-3b619cd13eamr1530860f8f.24.1752819203556;
        Thu, 17 Jul 2025 23:13:23 -0700 (PDT)
Received: from u94a ([2401:e180:8dfc:69e4:fbdd:a670:1a68:e610])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6cfd8esm6187795ad.137.2025.07.17.23.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 23:13:23 -0700 (PDT)
Date: Fri, 18 Jul 2025 14:13:15 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH bpf-next v5 2/2] selftests/bpf: Add tests with stack ptr
 register in conditional jmp
Message-ID: <l4eujzpq73pu7ilrgfdiu3b3xpif7wyfcs3dleyci6yw4i6b5z@sx5c32oejbp6>
References: <20250524041335.4046126-1-yonghong.song@linux.dev>
 <20250524041340.4046304-1-yonghong.song@linux.dev>
 <4goguotzo5jh4224ox7oaan5l4mh2mt4y54j2bpbeba45umzws@7is5vdizr6m3>
 <9b41f9f5-396f-47e0-9a12-46c52087df6c@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b41f9f5-396f-47e0-9a12-46c52087df6c@linux.dev>

On Wed, Jul 16, 2025 at 09:05:05AM -0700, Yonghong Song wrote:
> On 7/16/25 3:13 AM, Shung-Hsi Yu wrote:
> > Hi Andrii and Yonghong,
> > 
> > On Fri, May 23, 2025 at 09:13:40PM -0700, Yonghong Song wrote:
> > > Add two tests:
> > >    - one test has 'rX <op> r10' where rX is not r10, and
> > >    - another test has 'rX <op> rY' where rX and rY are not r10
> > >      but there is an early insn 'rX = r10'.
> > > 
> > > Without previous verifier change, both tests will fail.
> > > 
> > > Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> > > ---
> > >   .../selftests/bpf/progs/verifier_precision.c  | 53 +++++++++++++++++++
> > >   1 file changed, 53 insertions(+)
> > I was looking this commit (5ffb537e416e) since it was a BPF selftest
> > test for CVE-2025-38279, but upon looking I found that the commit
> > differs from the patch, there is an extra hunk that changed
> > kernel/bpf/verifier.c that wasn't found the Yonghong's original patch.
> > 
> > I suppose it was meant to be squashed into the previous commit
> > e2d2115e56c4 "bpf: Do not include stack ptr register in precision
> > backtracking bookkeeping"?
> 
> Andrii made some change to my original patch for easy understanding.
> See
>   https://lore.kernel.org/bpf/20250524041335.4046126-1-yonghong.song@linux.dev
> Quoted below:
> "
> I've moved it inside the preceding if/else (twice), so it's more
> obvious that BPF_X deal with both src_reg and dst_reg, and BPF_K case
> deals only with BPF_K. The end result is the same, but I found this
> way a bit easier to follow. Applied to bpf-next, thanks.

Argh, indeed I missed the sibling thread. Thanks for point that out.

Shung-Hsi

...

