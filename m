Return-Path: <stable+bounces-3139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE0F7FD431
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 11:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD0EF1C21114
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 10:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0391B273;
	Wed, 29 Nov 2023 10:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f6DmFnm0"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52E6BA;
	Wed, 29 Nov 2023 02:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rmJD+aYpwKfnMSY8EiaL3anh7OCP8CuiZJQUFpIlc2c=; b=f6DmFnm07pCKf5vCvLX5iJiXku
	0mt6ap+4UM2JIz9QRobfISt+nnqnUWngst5c23B2ABQC27GAr5POvMPvRz0Ur7jtzFIg86HESII4O
	qv3dMRC4FQL5kNCqQ4dDFE+9g13nopYSMEDp1MrK4zP0gz1vRXQpqWItVGoIubYDbVzsw95Kmo9jq
	SJE/vGNBqWHHQoJol9xG7dc7fj1nwOUDf8TFzlW8uirIBqnWdWLN/EmW+9KsRviXKESYIjocPrZcJ
	W8Qdb67/0EGqR1hhQazwItanBaGCbVh31yO3ouTEusmc+nNzJTGEunNAWzpYN4hIVuvkrnDcuLuHh
	600hduqQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r8Hru-00DIE6-BU; Wed, 29 Nov 2023 10:32:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 02130300293; Wed, 29 Nov 2023 11:32:34 +0100 (CET)
Date: Wed, 29 Nov 2023 11:32:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Zhengyuan Liu <liuzhengyuang521@gmail.com>
Cc: mingo@redhat.com, linux-perf-users@vger.kernel.org,
	stable@vger.kernel.org, =?utf-8?B?6IOh5rW3?= <huhai@kylinos.cn>,
	=?utf-8?B?5YiY5LqR?= <liuyun01@kylinos.cn>, huangjinhui@kylinos.cn,
	Zhengyuan Liu <liuzhengyuan@kylinos.cn>, acme@kernel.org
Subject: Re: Question about perf sibling_list race problem
Message-ID: <20231129103233.GD30650@noisy.programming.kicks-ass.net>
References: <CAOOPZo5oFZAs3sMcEgmTEZy3ef4jg630xL3mUBx3bvV6tQcdQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOOPZo5oFZAs3sMcEgmTEZy3ef4jg630xL3mUBx3bvV6tQcdQg@mail.gmail.com>

On Wed, Nov 29, 2023 at 05:33:33PM +0800, Zhengyuan Liu wrote:
> Hi, all
> 
> We are encountering a perf related soft lockup as shown below:
> 
> [25023823.265138] watchdog: BUG: soft lockup - CPU#29 stuck for 45s!
> [YD:3284696]
> [25023823.275772]  net_failover virtio_scsi failover
> [25023823.276750] CPU: 29 PID: 3284696 Comm: YD Kdump: loaded Not
> tainted 4.19.90-23.18.v2101.ky10.aarch64 #1
          ^^^^^^^^^^^^^^^^^^^

That is some unholy ancient kernel. Please see if you can reproduce on
something recent.

