Return-Path: <stable+bounces-186251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A4201BE6E8C
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 09:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C1BD4F8910
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 07:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5D223EA84;
	Fri, 17 Oct 2025 07:20:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4D310F2
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 07:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760685606; cv=none; b=c2vH+scV7geOuWf2DXqzGOt9IMIGuG7xDRyYzPPPxwIY3LsaojWlEN8Y0ITQ/AXtmKorhWzC8FWmsQoLgYkD5Y/Ux6LppbKxKfI7lre3vznTMVGfEsxBf6/abb2uh3RODp982D5O3pzf9FpHqOODnB+oH5m7yA814uq8lrAa13U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760685606; c=relaxed/simple;
	bh=jK4rsI2HNYFNacDxMQjMWAcHISCBhWzg2xESp8p66Dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kOCebATGatcvgGavgv+AxxLRFhvbqkHDpYE/cdS4YG6+m5tUMlDassCcayQN5XB/iOFsOfjafIvPAlmhXVC+eKplWO/4KkAGVdYRf+LQxnChFJambuGrwTZPhMF//m6MgxNLkQnzx6/FAa/z0LfLo2WmPstsjS6eKKh+eK0ATJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cnwQq1jDJz9sST;
	Fri, 17 Oct 2025 08:49:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RFjPPOnsb9An; Fri, 17 Oct 2025 08:49:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cnwQq0pngz9sSS;
	Fri, 17 Oct 2025 08:49:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 037C38B773;
	Fri, 17 Oct 2025 08:49:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id cxZ0vjnTr-9q; Fri, 17 Oct 2025 08:49:06 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id AC3D78B763;
	Fri, 17 Oct 2025 08:49:06 +0200 (CEST)
Message-ID: <bd6fbf70-bf31-4b95-86db-68c0626a3338@csgroup.eu>
Date: Fri, 17 Oct 2025 08:49:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel failing to build on 32-bit powerpc
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 debian-powerpc <debian-powerpc@lists.debian.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-stable <stable@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <eb8a89e43f01a920244bde9252cbe4f5c0e2d75a.camel@physik.fu-berlin.de>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <eb8a89e43f01a920244bde9252cbe4f5c0e2d75a.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Le 16/10/2025 à 21:03, John Paul Adrian Glaubitz a écrit :
> Hi,
> 
> could someone investigate the following build failure on powerpc [1], please?
> 
> In file included from /build/reproducible-path/linux-6.16.12/kernel/sched/build_policy.c:64:
> /build/reproducible-path/linux-6.16.12/kernel/sched/ext_idle.c: In function ‘is_bpf_migration_disabled’:
> /build/reproducible-path/linux-6.16.12/kernel/sched/ext_idle.c:893:14: error: ‘const struct task_struct’ has no member named ‘migration_disabled’
>    893 |         if (p->migration_disabled == 1)
>        |              ^~
> /build/reproducible-path/linux-6.16.12/kernel/sched/ext_idle.c:896:25: error: ‘const struct task_struct’ has no member named ‘migration_disabled’
>    896 |                 return p->migration_disabled;
>        |                         ^~
> 

I guess 6.16.12 is missing commit cac5cefbade9 ("sched/smp: Make SMP 
unconditional")

Christophe

