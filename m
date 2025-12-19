Return-Path: <stable+bounces-203091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 922B1CD0108
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 14:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9D3E3035241
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 13:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB352FD66D;
	Fri, 19 Dec 2025 13:28:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC1318D658;
	Fri, 19 Dec 2025 13:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766150909; cv=none; b=Jue8m1ZsyGdkegZuEPqrHW18Yx8plQahlFlyWf0MYZ6pG5/rZZEcre3ApNrnO1hhKcAK19ZPpAx5mgBeOQHM99HgdcmZlP+clTFFWGt5GnALA4kPP/FJmNX6AQTIUERoU47gaP0kClJtBZdxyVqKuyRBrqBgOeWFaKEF/XAzafM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766150909; c=relaxed/simple;
	bh=ZLChRNRK3ozRjOXev/dZqBKY8GgRjVfOvr0sZk/ezUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=al4C62OYIohmq8jysK0knW3ibyROoZoYUIMm/xxiLyqpaGYoYwmSfPx3ggE3K447AtJ6MPOzmAS9PBdrQCFTcuRjdQ1TyJDJcml4DB4xAprlBKwUqrKuGF4FpzFTvw2qai0GkMw7POKXjPivJbFeYpN5pgS5+5vlsRZsPYiyvoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.209])
	by APP-05 (Coremail) with SMTP id zQCowABn+QzxUkVpLOkuAQ--.17224S2;
	Fri, 19 Dec 2025 21:28:17 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: tglx@linutronix.de
Cc: anna-maria@linutronix.de,
	frederic@kernel.org,
	lihaoxiang@isrc.iscas.ac.cn,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] clockevents: add a error handling in tick_broadcast_init_sysfs()
Date: Fri, 19 Dec 2025 21:28:17 +0800
Message-Id: <20251219132817.625559-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <875xa2bwso.ffs@tglx>
References: <875xa2bwso.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABn+QzxUkVpLOkuAQ--.17224S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw4rJr1kJw1xKFW5WrW8Crg_yoWkWFg_Gr
	4jvr93ur48ur9a9asxCwn5ZFy09FsrKrW8CryUtr4fJrW5JrWkurs8WFn3XrnruF12k39r
	trZ8WF97GF13ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb48FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbhvttUUUU
	U==
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiDAcBE2lFN+VH2wAAs7

On Fri, 19 Dec 2025 11:17:27 +0100, Thomas Gleixner wrote:
>On Thu, Dec 18 2025 at 17:06, Haoxiang Li wrote:
> > If device_register() fails, call put_device() to drop
> > the device reference.
> >
> > Fixes: 501f867064e9 ("clockevents: Provide sysfs interface")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
> > ---
> >  kernel/time/clockevents.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
> > index a59bc75ab7c5..94e223cf9c74 100644
> > --- a/kernel/time/clockevents.c
> > +++ b/kernel/time/clockevents.c
> > @@ -733,8 +733,12 @@ static __init int tick_broadcast_init_sysfs(void)
> >  {
> >  	int err = device_register(&tick_bc_dev);
> >  
> > -	if (!err)
> > -		err = device_create_file(&tick_bc_dev, &dev_attr_current_device);
> > +	if (err) {
> > +		put_deivce(&tick_bc_dev);
> 
> My brain compiler tells me that this was not even compiled. Try again.

Sorry for my oversight. However, I found that tick_bc_dev is a static struct.
Is the error handling here pointless?


