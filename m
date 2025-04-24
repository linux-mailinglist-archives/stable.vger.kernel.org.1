Return-Path: <stable+bounces-136619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D982FA9B669
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 20:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D16B99A48D5
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 18:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF62E290BD0;
	Thu, 24 Apr 2025 18:33:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8525E29009A
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 18:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745519591; cv=none; b=ehwzyLpEJshPG5oMfM3R1zoJJnLBV/n4axo93xh+FzQWLOn0uugL+GFZv+6LlIP7VoNkfE12g9shtU3nWC3rMUL+dn78t1l/YtGB7B3ua3csm2bf//QOvGdFYF3CcOJL4E5cW+9sO5i0F17lP8PJhUkhw91mismo+0/Z00NFYWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745519591; c=relaxed/simple;
	bh=FDBpEEGT/miDo13TyAxImdqxgoFFxrrIZn6xcnHNx2I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FDr7q1ohRvRGIDbUAz3Uq4i3DN/UVwuti/RvlTctpzaLGHQi/Y00Qz1MIPv8qBexPu/myPNFJoAV/qx9e/K4iGkwUjXUt/1CtQIG0BVlwdb6rFEV+gm7btACCui6OPX9crjncPrj7Ab5JcLKGlQ81ieSZn2Qzp146Yvk1oa85Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1u81Ni-0006Tz-46; Thu, 24 Apr 2025 20:33:06 +0200
Date: Thu, 24 Apr 2025 20:33:06 +0200
From: Florian Westphal <fw@strlen.de>
To: stable@vger.kernel.org
Cc: pablo@netfilter.org, linux@slavino.sk
Subject: stable request: eaaff9b6702e ("netfilter: fib: avoid lookup if
 socket is available")
Message-ID: <20250424183306.GA24548@breakpoint.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Greg, hi Sasha,

Could you please queue up

eaaff9b6702e ("netfilter: fib: avoid lookup if socket is available")

for 6.14 and 6.12?

Unfortunately I did not realize that the missing handling of
'input' is not just a missing optimization but an actual bug fix, else
I would have split this patch in two.

The bug exists since 5.19, but its not a regression ('never worked').

Given noone noticed/reported this until this week
(https://lore.kernel.org/netfilter/20250422114352.GA2092@breakpoint.cc/),
we think it makes sense to only apply this to the two most recent trees
and keep the rest as-is, users of those trees evidently don't use the
b0rken configuration or they would have complained long ago.

The commit cherry-picks cleanly to both.
If you disagree let me know, I could also make a stable-only patch that
only contains the bug fix part of the mentioned commit.

Thanks!

