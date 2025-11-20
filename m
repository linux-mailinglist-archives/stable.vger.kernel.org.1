Return-Path: <stable+bounces-195372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC33C75B69
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 18:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id E5A4E30235
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC403242BA;
	Thu, 20 Nov 2025 17:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FmEp7vrT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0148211A14
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763659744; cv=none; b=o+njybgxofr/CFwD5dkQoLfJ91rw5lnZb4s4DFroKddOdS4w0mRUL3Jxz09qQ92xQ3TsjpFaoNW+UsTnOnuIXnuLLzN2jRqymWwIjqnSnBitkYiYpiY8PYh/6EiAl7L8Pjrq7fWxxhR9QBdeBSnSSoRDEcH5BFGN3ZSnVFUCKqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763659744; c=relaxed/simple;
	bh=Q3YbkW4pm3fe9lci28iim7y72WYJiOBG2mhv4u/6RMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L781E7xhFFJWS1KOCoejYENnrfWF0Mplvi9aEHVGtw/1LNqtuGUtrHgcOWw4XyUHj148vpe7YXCuLrhpRWw57zvskLX5Tqec8IO28ZPGms/YJwKMiImnhDnuvq9kbR+qdc5lFuY0ZT1ZAq/P/CA5VOyUBzpNTHJTmljoMZW4C+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FmEp7vrT; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29852dafa7dso214955ad.1
        for <stable@vger.kernel.org>; Thu, 20 Nov 2025 09:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763659741; x=1764264541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ky44eDmWt52pUOOxiqPKy3Mts+JZA6YHrJAlYxbKBlQ=;
        b=FmEp7vrT1SJWLB9uT9LZ9H99A9bmDHR/sfk0JErwXdhjY+VRDaeXWCYXIJFNaShiN3
         873YwFyhNIOnhdhhdDHThT5uXhu6YlqPtWKVUqGyLI++t2VEVyXePNzzLagtGKA62v5D
         KRmj6/7ZkTlncK3nmJFh4i+VuBAtYAGC/gRfeQYjA/9MdPMApMF4LRrh3WELMT1WScYu
         rIPAvbjI9mGAzKUjiAGfbwAj28AFq7gOHbB1fhvtcTYHkBpzgmcpkmijO5mV6xBseRYr
         bUtFe2gqc+a3lLcho2obNHqJ/pTzNd+h0QMzNdSGzg0nOajzkryt1yiyMNyauKXZLmIo
         UA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763659741; x=1764264541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ky44eDmWt52pUOOxiqPKy3Mts+JZA6YHrJAlYxbKBlQ=;
        b=w34V0KeZ20IkSqErZtftl76mTL8taU2DqCFNSns5BJYles65OZxx1wOJ2R3yA6lF9U
         qg0u+WKZJqkbIuQ5Apo0wtz398TEYdUYSv2zhVO+uers7/009f0rXpwbDBHW1FGAt1x0
         S1gx7apiUhqSio8k4HI1HAAOGXlSJA1Dez6Qqx1nhagFFBs8FHxuT0awcu3+sN9tHToc
         KIJO7chLPbpUJSQy2YXfrXhRTf2e4PQWY5uaR0sZZySj6yFvgHZapLgSCFbu/rZ1AEPC
         nktOyQGv5LsYsyIcF7arsY9t+TKIe5mReBNtmlcJRRd5sHmw6pRPCKEvnHlUwgmXjqFX
         9OAA==
X-Forwarded-Encrypted: i=1; AJvYcCWucqbAnDbujXB5V/a+QcNvc4aorlROo/H/jHJ5oEUaRf17u4ElTfhMMlBC/8PAZnx1x5gjdHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMqs5nykGRUnUWqYVxYlG+way3YDDTvxIygMN6vVSx0GoOLK23
	wAaMrtLl2+kIFJHIQsZU+6yRdOS50RYjr5or500revbqsvXA05esgwHdBaC1IRm/6fwPecuZWGa
	O1gtWiA==
X-Gm-Gg: ASbGncsGwxOJ63DqWvWocMf6Qn1Hk39VZbiNJ6r/4uNPgvAzNVD98QMnaalKXX63ND0
	8KTuKXeyMhnK/Afy54WBhy/PN9bDgoeVeGOalvUT2W7PnDGqCfwesbmx33nM56LG0NmvcRO21vW
	WXobYG4r2/Q6WagPXHsGi0pndz3Q3dWCc5T0cFlQ1VVCbVqIkQdmoEOsEmyI2mhuNil7uffcpdN
	9Et6LTlMbKGDkT2LL6avtJyiG66biM3RP8Y1YXqZ0/TF/NlNS+G1WzT7B908eBO7DpTS456KF6V
	0hUcneaCkXopeEh/yvxSNJQh0GEDxm/SyJG9+VfUlfzwlmvJXc7mwXFncJd7AXESfSjqCL2TutE
	0kTb2r/2q9X2+ZNUn96eayZ2hVjwRP+a2Tlcnnb5+89dOWK29zXfBY0Ze83Rp2/2EOMPxUifgrP
	zmM/ue3jEnyioU2gg2ws+ivU/W1j0BwqwPgetxR4JSteOEbBiab8k9SlcwtS0pfu5AvUJKA2Ib2
	8Jx4+3IE2DmhSQbyuBH75HdtvTzYhZhbf1I
X-Google-Smtp-Source: AGHT+IHQS7r9GmJbj+JcdLmuvcj/jStI1KW4O7/kVj6DkiGvxhcMNPJ5UC/nBeAze6+QYwLUmQ29PQ==
X-Received: by 2002:a17:902:e806:b0:265:e66:6c10 with SMTP id d9443c01a7336-29b5c4abf7bmr4626455ad.4.1763659740782;
        Thu, 20 Nov 2025 09:29:00 -0800 (PST)
Received: from google.com (116.241.118.34.bc.googleusercontent.com. [34.118.241.116])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f174c9dasm3372756b3a.65.2025.11.20.09.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 09:29:00 -0800 (PST)
Date: Thu, 20 Nov 2025 17:28:55 +0000
From: Carlos Llamas <cmllamas@google.com>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, broonie@kernel.org, catalin.marinas@arm.com,
	leitao@debian.org, luca.ceresoli@bootlin.com, mark.rutland@arm.com,
	matttbe@kernel.org, mbenes@suse.cz, puranjay@kernel.org,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] scripts/decode_stacktrace.sh: fix build
 ID and PC source" failed to apply to 6.17-stable tree
Message-ID: <aR9P13YfvZ6AMSfC@google.com>
References: <2025112031-catalyze-sleep-ba6e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025112031-catalyze-sleep-ba6e@gregkh>

On Thu, Nov 20, 2025 at 04:56:31PM +0100, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.17-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.17.y
> git checkout FETCH_HEAD
> git cherry-pick -x 7d9f7d390f6af3a29614e81e802e2b9c238eb7b2
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112031-catalyze-sleep-ba6e@gregkh' --subject-prefix 'PATCH 6.17.y' HEAD^..
> 
> Possible dependencies:

The dependencies I missed to specify are the following 2 fixes:
  d322f6a24ee5 ("scripts/decode_stacktrace.sh: symbol: avoid trailing whitespaces")
  4a2fc4897b5e ("scripts/decode_stacktrace.sh: symbol: preserve alignment")

They apply cleanly on top of linux-6.17.y:
  git cherry-pick -xs d322f6a24ee5 4a2fc4897b5e 7d9f7d390f6a

I've also verified the expected fixes work for all 3 patches.

Greg, do you need me to send these?

--
Carlos Llamas

