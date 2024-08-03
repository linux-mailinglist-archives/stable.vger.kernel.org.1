Return-Path: <stable+bounces-65330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E810946ABB
	for <lists+stable@lfdr.de>; Sat,  3 Aug 2024 19:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFE7C281ABD
	for <lists+stable@lfdr.de>; Sat,  3 Aug 2024 17:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33A513AD8;
	Sat,  3 Aug 2024 17:53:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1764C74
	for <stable@vger.kernel.org>; Sat,  3 Aug 2024 17:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722707603; cv=none; b=DMC33K8N3W8iIG6jnJobCkskaYtgs8mjjC/CiEonFlXbpuVZhCefZiRZWLhzEqKGiwsnwr6L3RAoo70c6+cvs7tLsHOt32lwrk7QhYFcS1QTFj60zvauv6ReR+8JIjb4iKFfFIPUPaV/kSVsYEP1NcHa1JPpBh9X6iiLpVcoZH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722707603; c=relaxed/simple;
	bh=m7OpUkYbqLkzyS+tlUf+Cjj3u6nTKSyxTGr52UL23N8=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type; b=V1ewiH6+QeSb71dR/pDe5rcUorNtA5fwKUhxWaKB/qY90h78y3kUVQWRl6FWSg/vzwta3330LebHpU0KBxqgZuaQrGREd51Fkv8NSsX+BrSYa5gbYWEwtqQl8kNTvykHSOzx4jLpysTAi+tRWg0C7Yerlh0gozBbUGseXQ2SaAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=elrepo.org; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=elrepo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glks-stable4@m.gmane-mx.org>)
	id 1saIrS-0003HF-OP
	for stable@vger.kernel.org; Sat, 03 Aug 2024 19:48:10 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: stable@vger.kernel.org
From: Akemi Yagi <toracat@elrepo.org>
Subject: Re: bpf tool build failure in latest stable-rc 6.1.103-rc3 due to
 missing backport
Date: Sat, 3 Aug 2024 17:48:05 -0000 (UTC)
Message-ID: <v8lqgl$15bq$1@ciao.gmane.io>
References: <1722571545-7009-1-git-send-email-hargar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
User-Agent: Pan/0.149 (Bellevue; 4c157ba git@gitlab.gnome.org:GNOME/pan.git)

On Thu, 01 Aug 2024 21:05:45 -0700, Hardik Garg wrote:

> bpf tool build fails for the latest stable-rc 6.1.103-rc3 The error
> details are as follows:
> prog.c: In function 'load_with_options':
> prog.c:1710:23: warning: implicit declaration of function
> 'create_and_mount_bpffs_dir' [-Wimplicit-function-declaration]
>  1710 |                 err = create_and_mount_bpffs_dir(pinmaps);
>       |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~

> The commit causing this failure in 6.1.103-rc3:
> bc1605fcb33bf7a300cd3ac5c409a16bda1626ba
> 
> It appears that the commit from the 6.10 series is missing in this
> release candidate:
> 478a535ae54a ("bpftool: Mount bpffs on provided dir instead of parent
> dir") 
> 
> Thanks,
> Hardik

Build of final 6.1.103 fails due to the reported issue.

Can we drop this commit until we figure out a proper fix?

Thanks,
Akemi


