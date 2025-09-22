Return-Path: <stable+bounces-180957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF515B916D4
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 15:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFFF53B0BA6
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 13:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5061D30C115;
	Mon, 22 Sep 2025 13:37:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139CA30BF4F;
	Mon, 22 Sep 2025 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758548232; cv=none; b=E8gRuaRiUoTj8ltNCL5L8UJPLlmHDkh+tU5wM5kFYervhuKyfuwLtgnC7Drrobx37QZpC4aEXObcMOPKrJQ5yPoNYfADhfxabddYOKP1Wsh9xEBcpkH2cffpEg0s8csxN+KWqgY5dvJQ/HyHSlCONfDxmoFkP9QQJ9Dsz/I8reg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758548232; c=relaxed/simple;
	bh=9AVpFoSfSEYUsV1HJLh3F//s7d4/SUdPNyNspuKkJ8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=J/58FLQsN8YXwv4ke3EWDDdGvVE07wRxycaxE5uZ5vyENMOFZ7oW2mwfvYzJaDPK+CGSEscHwHSmIsBKGB6FxdrGyxUwziFoKqd0yOcB/1yPu5l5uMVNm3kVvMRdv6NZ/6CCJZF2Pe5rEdvyy1cepM4tHglsTOSX/FP1igzGUZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-03 (Coremail) with SMTP id rQCowABnsXvFUNFoKydEBA--.46359S2;
	Mon, 22 Sep 2025 21:36:17 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: dan.carpenter@linaro.org
Cc: akpm@linux-foundation.org,
	arnd@arndb.de,
	dominik.karol.piatkowski@protonmail.com,
	dpenkler@gmail.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	make24@iscas.ac.cn,
	matchstick@neverthere.org,
	paul.retourne@orange.fr,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] staging: gpib: Fix device reference leak in fmh_gpib driver
Date: Mon, 22 Sep 2025 21:36:05 +0800
Message-Id: <20250922133605.24777-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <aNEy7LsnKa50Pq3c@stanley.mountain>
References: <aNEy7LsnKa50Pq3c@stanley.mountain>
X-CM-TRANSID:rQCowABnsXvFUNFoKydEBA--.46359S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFyDGr4ftw4kuw1kJFyrZwb_yoW8KF4xpr
	47WFyjkrWDXws3CayUXw48XFWa93yIy345ur1DJ34ruFs5ua4Skw4qgw45W3s8ArZ7Jr4j
	ya1UWa1v93yDZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwV
	W5GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUgvtAUUUUU
	=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

On 9/22/25 19:28, Dan Carpenter wrote:
> On Mon, Sep 22, 2025 at 04:45:12PM +0800, Ma Ke wrote:
> > The fmh_gpib driver contains a device reference count leak in
> > fmh_gpib_attach_impl() where driver_find_device() increases the
> > reference count of the device by get_device() when matching but this
> > reference is not properly decreased. Add put_device() in
> > fmh_gpib_attach_impl() and add put_device() in fmh_gpib_detach(),
> > which ensures that the reference count of the device is correctly
> > managed.
> > 
> > Found by code review.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 8e4841a0888c ("staging: gpib: Add Frank Mori Hess FPGA PCI GPIB driver")
> > Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> > ---
> > Changes in v2:
> > - modified the free operations as suggestions. Thanks for dan carpenter's instructions.
> > ---
> 
> Actually, it turns out that this isn't the right approach.  Sorry.
> This will introduce double frees.
> 
> The caller looks like this:
> 
> drivers/staging/gpib/common/iblib.c
>    204  int ibonline(struct gpib_board *board)
>    205  {
>    206          int retval;
>    207  
>    208          if (board->online)
>    209                  return -EBUSY;
>    210          if (!board->interface)
>    211                  return -ENODEV;
>    212          retval = gpib_allocate_board(board);
>    213          if (retval < 0)
>    214                  return retval;
>    215  
>    216          board->dev = NULL;
>    217          board->local_ppoll_mode = 0;
>    218          retval = board->interface->attach(board, &board->config);
>    219          if (retval < 0) {
>    220                  board->interface->detach(board);
> 
>    So if the attach() fails, we call ->detach() which works.
> 
>    221                  return retval;
>    222          }
> 
> It's weird because the fmh_gpib_pci_detach() function does have a
> put_device() in it:
> 
> 	if (board->dev)
> 		pci_dev_put(to_pci_dev(board->dev));
>                 ^^^^^^^^^^^
> 
> The detach functions are really similar...
> 
> regards,
> dan carpenter
Thank you very much for your patient reply. Indeed, I also carefully 
examined the implementations of the functions fmh_gpib_detach() and 
fmh_gpib_pci_detach(), and their code is indeed very similar. I also 
took note of the double free issue you mentioned. In patch v3, I will 
refer to the implementation of fmh_gpib_pci_detach() and only add 
put_device() in fmh_gpib_detach(). I will not make any modifications 
to other functions. Once again, thank you for your patient guidance, 
from which I have benefited greatly.

Best regards,

Ma Ke



