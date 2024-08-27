Return-Path: <stable+bounces-70344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C89F960ABC
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338E41F23A2C
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 12:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562981BAED5;
	Tue, 27 Aug 2024 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I6/dgtdM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A60C1A01C4
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 12:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762660; cv=none; b=CfRvbZplYD9RgysqvOcSS+0iGPmJn8XUJGCz/ytIWfWkaGWs5ctXwgxe6UKhurieuWw/24jDmHicSHJE35+fH1zGHHCVqt6JmBvXHMQC3auyh0WBY/iiUfmXkXkh8iPotnrf5aXoh3ziCi558G7TZDUkzidLOLbJg6vwSt9auso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762660; c=relaxed/simple;
	bh=IiLfwQyxPqpwg3jVDzvYWW6ZkMv5FRzEScMrrYcooTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoyMPxkCPGww80KrYxumyhHcLAq+pe38KgvduCbGvgGhy0mtmO1k1gf2uY7ErI5zpK3RIrGDieTdfcs5XdDrr0Qr9+YvuecN/OgrXoStzUKaOBwCz49KQDnJ/Gp/Ygm6DVcN1pUFJKoh0EMOYEp1N+GtO1heH9anE6+bocGtJRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I6/dgtdM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BA3C4FF5C;
	Tue, 27 Aug 2024 12:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724762659;
	bh=IiLfwQyxPqpwg3jVDzvYWW6ZkMv5FRzEScMrrYcooTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I6/dgtdMXvISVnelE1Z9bCEBU8ig2g6j2brTWCvQZvs0u/Bsgbq890aLcU8gaypry
	 FpKCR4004bBpHqZsbIaBTNRK3jwGO1hUSJJ6ZqAyj1CS4Bd25fvdX317LW5tEntDD+
	 2f+JhW9NssiIxB5vs3ETMZtoUPCCctBX7JDe/kMc=
Date: Tue, 27 Aug 2024 14:44:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: maxtram95@gmail.com, maxim@isovalent.com,
	Sherry Yang <sherry.yang@oracle.com>, andrii@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
	john.fastabend@gmail.com, sashal@kernel.org, stable@vger.kernel.org
Subject: Re: BPF selftest failed to build
Message-ID: <2024082700-manhood-overhead-9a32@gregkh>
References: <20240711184323.2355017-2-maxtram95@gmail.com>
 <20240823014514.3622865-1-sherry.yang@oracle.com>
 <xycnahurpkbaym42w7lm3asy3uzqxowvxkckvbbpoqphxo2dad@c7z4ztfe4w6r>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xycnahurpkbaym42w7lm3asy3uzqxowvxkckvbbpoqphxo2dad@c7z4ztfe4w6r>

On Fri, Aug 23, 2024 at 10:50:29AM +0800, Shung-Hsi Yu wrote:
> On Thu, Aug 22, 2024 at 06:45:14PM GMT, Sherry Yang wrote:
> > Hi All,
> > 
> > We found BPF sefltest fail to build with following error:
> > 
> > 08-09 20:39:59 DBG: |output|: progs/test_global_func10.c:24:1: error: unknown type name '__failure'
> > 08-09 20:39:59 DBG: |output|: __failure __msg("invalid indirect access to stack")
> > 08-09 20:39:59 DBG: |output|: ^
> > 08-09 20:39:59 DBG: |output|: progs/test_global_func10.c:24:17: error: expected parameter declarator
> > 08-09 20:39:59 DBG: |output|: __failure __msg("invalid indirect access to stack")
> > 08-09 20:39:59 DBG: |output|:                 ^
> > 08-09 20:39:59 DBG: |output|: progs/test_global_func10.c:24:17: error: expected ')'
> > 08-09 20:39:59 DBG: |output|: progs/test_global_func10.c:24:16: note: to match this '('
> > 08-09 20:39:59 DBG: |output|: __failure __msg("invalid indirect access to stack")
> > 08-09 20:39:59 DBG: |output|:                ^
> > 08-09 20:39:59 DBG: |output|: progs/test_global_func10.c:24:52: error: expected ';' after top level declarator
> > 08-09 20:39:59 DBG: |output|: __failure __msg("invalid indirect access to stack")
> > 08-09 20:39:59 DBG: |output|:                                                    ^
> > 08-09 20:39:59 DBG: |output|:                                                    ;
> > 08-09 20:39:59 DBG: |output|: 4 errors generated.
> > 08-09 20:39:59 DBG: |output|: make: *** [Makefile:470: /root/oltf/work/linux-bpf-qa/tools/testing/selftests/bpf/test_global_func10.o] Error 1
> > 08-09 20:39:59 DBG: |output|: make: *** Waiting for unfinished jobs....
> > 
> > It happens from the commit e30bc19a9ee8("bpf: Allow reads from uninit
> > stack"). We did a further look, '__failure' is defined in
> > tools/testing/selftests/bpf/progs/bpf_misc.h, and was 1st introduced
> > in commit 537c3f66eac1("selftests/bpf: add generic BPF program
> > tester-loader") which is not backported to linux-5.15.y.
> > 
> > So we may need to revert the patch, or fix it.
> 
> To fix it I think we just need to drop the use of __failure and __msg in
> progs/test_global_func10.c, and update the "struct test_def tests[]"
> table in prog_tests/test_global_funcs.c with the new verifier rejection
> message.
> 
> On the other hand I believe commit 537c3f66eac1("selftests/bpf: add
> generic BPF program tester-loader") should be relatively easy to
> backport, just picking that commit up and resolving simple conflict in
> Makefile should be enough. It will also save a lot of future headaches
> like this one.

Please submit a patch like this and we will be glad to pick it up.

thanks,

greg k-h

