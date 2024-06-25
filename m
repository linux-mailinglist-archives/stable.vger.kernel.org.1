Return-Path: <stable+bounces-55149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B21A916005
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 09:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AEF91C20A28
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 07:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5439145A09;
	Tue, 25 Jun 2024 07:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ad+N1xrR"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CDC1CABB
	for <stable@vger.kernel.org>; Tue, 25 Jun 2024 07:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719300525; cv=none; b=m/kBE0GBGbfTp5K0bTnRRORcCt93rlJ8DPf5X07tFdPcQTu20cDM+p8z5JOzx8SsSFO+HSiuajBtkebMzc/ykIMrWd2INShF7MkV+5eDKZLivqWgze0yM3FJV+DnJ8zAJ8Q4rh4natjfq+ax/0UJkCzTdlXcbMoFVskVIJYuhj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719300525; c=relaxed/simple;
	bh=WccSwBf4SyPiSOyhAyMo9y3z0T3ER1Z/c774+Y7SLS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzOYtgjLGxD0SnEFv8oy8MTtCH5/goXgjqY55V+8ukIXe9R4I+Z+a6sbcrcfmGXL0LAdq+obJLuU8daEh/xG5mkVtCNfTmUXSeKbYFM5eT+I524povxdpEaPfAMzl/Pao+tYYsHhRxRx80WIzlNjdNwfD5iN3O9Cqkb9TNR0tus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ad+N1xrR; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ec50a5e230so36037421fa.0
        for <stable@vger.kernel.org>; Tue, 25 Jun 2024 00:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719300521; x=1719905321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ci1y3k9MXr5pudqw18c9Q+UzuG7pSLgljqc8hyk4TZM=;
        b=ad+N1xrRL4ouwEePWUiGXoXv8jQ9aoDJOErdV58pwIqpOndLmpn3iftXyPpERyrTe8
         0H73HoI6OceCOSX3wqFmF0wUpCTv87FGtzgrWVUpDvw8KqqU5mNzzXcjpG/hD5ofV+6H
         L8k5ycUCxdhw8PkYqYy0WxBK8gfLn4poI9w3mBZY5x30AVOf2Ge5ic957TAMssgEQVCu
         onVKBA8k5MyN90y1H+uchHeVxK4zlPTQ7Ag0j0T5blBCMczxW0Z9TtHyS7eBNe5yfhG6
         biwwh53tuXSGorjUXrG3PFdEqwGBG4TVbJCx9VKy5N2il7tTSjMapGkmns1+jHVhQ2cW
         S+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719300521; x=1719905321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ci1y3k9MXr5pudqw18c9Q+UzuG7pSLgljqc8hyk4TZM=;
        b=OJD8NeKNnFA2ncaJVPDBcUtYM4+3XE0qOo0U7R6o6/SzkZ3UrG/oXEFYhxOxfRpW1w
         fLZCE7jwfUm749Ev76aYiZQjbHYpplKolmRDxKiWFR5vClHajvqwpBFERDkFhefip15x
         umZkRr+oJPvWEKjilKSWt71jtk83MT0QNFPaxa7hjmfZ8+3MNFiK/vWX0LTL1qJizRqC
         6cda4JIAgBdP5JCaW7+N5CYg/Otyi5Qfo6vNo10LUjzE4+HsM2usty/tEnuPsY+yMqqS
         AGUmhyYpRZ5pWCHS0UdciEY70VWcE4rWp/fQeJMbPdG4kQhwjmr+c7I3ChcbYUIqGrOf
         PZdA==
X-Forwarded-Encrypted: i=1; AJvYcCWFKVpl2aAgJkaNutdLVfmNwS+d/PjUeu0T/BWmeinrXLD0Xai5/lFZEP+0FgL5zupMAmeFPc/EJwrV0HKOBSah/Qe/PsJg
X-Gm-Message-State: AOJu0YwT6nyn38o6mnsrfPBRhwNscX2Mnh8d00G+tEuKPnJO2p0+O+Zj
	k72PuuqTG2pYdUKICs9PPSVWL6ZjUS/1jZDq8L1i1kSvWLcjo0oQp5FU+Y8eByY=
X-Google-Smtp-Source: AGHT+IHgRyrArRtWYZEVUjlBl/I3XuhwxseoLK+2NIr1pH6eV1FYrFwEzgcTH181B5vqFmgW366W9Q==
X-Received: by 2002:a2e:8817:0:b0:2ec:5abf:f3a8 with SMTP id 38308e7fff4ca-2ec5b269a0amr43538961fa.8.1719300521299;
        Tue, 25 Jun 2024 00:28:41 -0700 (PDT)
Received: from u94a (39-9-37-44.adsl.fetnet.net. [39.9.37.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fa1d3773d1sm47662215ad.270.2024.06.25.00.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 00:28:40 -0700 (PDT)
Date: Tue, 25 Jun 2024 15:28:31 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	stable@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, yhs@fb.com, 
	mykolal@fb.com, luizcap@amazon.com, Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: Re: [PATCH 6.1.y v2 1/6] bpf: allow precision tracking for programs
 with subprogs
Message-ID: <tof56dmde2ykrnqy33pz7evpzlwskpxnmxf3wa4lkeinhjung6@zthg6lsnmnwf>
References: <20230724124223.1176479-1-eddyz87@gmail.com>
 <20230724124223.1176479-2-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724124223.1176479-2-eddyz87@gmail.com>

Hi Greg,

On Mon, Jul 24, 2023 at 03:42:18PM GMT, Eduard Zingerman wrote:
> [ Upstream commit be2ef8161572ec1973124ebc50f56dafc2925e07 ]
> 
...
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
...
> @@ -2670,6 +2679,11 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx,
>  			 */
>  			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL && insn->imm == 0)
>  				return -ENOTSUPP;
> +			/* BPF helpers that invoke callback subprogs are
> +			 * equivalent to BPF_PSEUDO_CALL above
> +			 */
> +			if (insn->src_reg == 0 && is_callback_calling_function(insn->imm))
> +				return -ENOTSUPP;
>  			/* regular helper call sets R0 */
>  			*reg_mask &= ~1;
>  			if (*reg_mask & 0x3f) {

Looks like the above hunk is slightly misplaced.

In master the lines are added _before_ the BPF_PSEUDO_KFUNC_CALL check,
resulting in deviation from upstream as well as interfering with
backporting of commit be2ef8161572 ("bpf: allow precision tracking for
programs with subprogs") to stable v6.1.

What would be the suggested action here?
1. Send a updated version of the whole be2ef8161572 patch to stable
2. Send a minimal refresh patch like the one found in this email to
   stable
3. Adapt to this deviation in my backport of commit be2ef8161572 for
   stable

Shung-Hsi

...

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5d4510fb2be7..227dc10f6baa 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2673,17 +2673,17 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx,
 		if (opcode == BPF_CALL) {
 			if (insn->src_reg == BPF_PSEUDO_CALL)
 				return -ENOTSUPP;
+			/* BPF helpers that invoke callback subprogs are
+			 * equivalent to BPF_PSEUDO_CALL above
+			 */
+			if (insn->src_reg == 0 && is_callback_calling_function(insn->imm))
+				return -ENOTSUPP;
 			/* kfunc with imm==0 is invalid and fixup_kfunc_call will
 			 * catch this error later. Make backtracking conservative
 			 * with ENOTSUPP.
 			 */
 			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL && insn->imm == 0)
 				return -ENOTSUPP;
-			/* BPF helpers that invoke callback subprogs are
-			 * equivalent to BPF_PSEUDO_CALL above
-			 */
-			if (insn->src_reg == 0 && is_callback_calling_function(insn->imm))
-				return -ENOTSUPP;
 			/* regular helper call sets R0 */
 			*reg_mask &= ~1;
 			if (*reg_mask & 0x3f) {

