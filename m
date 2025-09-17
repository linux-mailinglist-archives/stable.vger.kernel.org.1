Return-Path: <stable+bounces-179835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F52B7C783
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9D6E16343F
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB413431FA;
	Wed, 17 Sep 2025 12:03:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9167E1B394F;
	Wed, 17 Sep 2025 12:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758110605; cv=none; b=ofI6JcY1n2BtOTIX+2YO7N/ynDqLmo3wXwGIYlBsgGjkcH9/B/91N+lFzI6b3yl8uoHVoX4giRNtuVtEPP9QYKTdVyCNzvknWyNBUaSjoKFgk3eUp7FOYSPf/Gl42q88Ltv66t3Vku6GrYrmQam5aSOFQdK2YIFyE/AcuO+9GPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758110605; c=relaxed/simple;
	bh=PeD5ipKnqWAnoXCl9DWjmZnd/4y6h3z7ghiA+7tKM60=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=g0miAzJznsIKgj93G0tSrkd1w1GJmV7GlcOGFmIkVRqUw3zMFIPL5+1iyseJvgxmoFIMkRXgml2OEkM+piWhIgiN7Jl62RgOEilE3tTW3yXlY17DM9/pMj45LwMdMzs4FTahNI/vKtwqVeOk8YxmRHgoCkpoc3FL7fSJQIbi8B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.107] (unknown [114.241.87.235])
	by APP-05 (Coremail) with SMTP id zQCowADnhxF7o8poUhdeAw--.4222S2;
	Wed, 17 Sep 2025 20:03:08 +0800 (CST)
Message-ID: <b68478db-5a8c-4b5f-a4d1-f4202ca1f062@iscas.ac.cn>
Date: Wed, 17 Sep 2025 20:03:08 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Charlie Jenkins <charlie@rivosinc.com>, Yangyu Chen <cyy@cyyself.name>,
 Han Gao <rabenda.cn@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Inochi Amaoto <inochiama@gmail.com>, Vivian Wang <wangruikang@iscas.ac.cn>,
 Yao Zi <ziyao@disroot.org>
From: Vivian Wang <wangruikang@iscas.ac.cn>
Subject: riscv: Backport request for mmap address space fixes to 6.6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zQCowADnhxF7o8poUhdeAw--.4222S2
X-Coremail-Antispam: 1UD129KBjvdXoWrJrWfur1kAw1xCFyxAry5Jwb_yoWxXrg_GF
	1UJrWxJa4UXFWUWFWUKrWrArn5CaykZ3y3Jrs7Ww4IyF4UC3W7Ga1vkry8CwsrAF47AF93
	t3WIya4Svr12qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkI
	wI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Hi,

I would like to request backport of these two commits to 6.6.y:

b5b4287accd702f562a49a60b10dbfaf7d40270f ("riscv: mm: Use hint address in mmap if available")
2116988d5372aec51f8c4fb85bf8e305ecda47a0 ("riscv: mm: Do not restrict mmap address based on hint")

Together, they amount to disabling arch_get_mmap_end and
arch_get_mmap_base for riscv.

I would like to note that the first patch conflicts with commit
724103429a2d ("riscv: mm: Fixup compat arch_get_mmap_end") in the stable
linux-6.6.y branch. STACK_TOP_MAX should end up as TASK_SIZE, *not*
TASK_SIZE_64.

Thanks,
Vivian "dramforever" Wang



