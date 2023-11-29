Return-Path: <stable+bounces-3182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BDC7FE2D6
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 23:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A98EA1C20A39
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 22:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED262B9D2;
	Wed, 29 Nov 2023 22:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Zexjm4Co"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567834CB3A
	for <stable@vger.kernel.org>; Wed, 29 Nov 2023 22:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57631C433C7;
	Wed, 29 Nov 2023 22:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1701296143;
	bh=plgOXsBw6Cgzi7c+sOMbPbteFDD/cEFFdXdKvhv6+P4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zexjm4Co0EhbtqVufBP3QVY5t/FKctGeVJLCxYNrdXXGByHewpU1LSj2DZ412YRXs
	 mT6+LLpxo81J1C8HyW3PRtesuArvpT+ocnvARABWCODRJ+D/rCMN1X+4Mh339MGFjK
	 GgEFdo6cTQWzLyo7bLsyjdcIN75ceQHfteCUres8=
Date: Wed, 29 Nov 2023 14:15:42 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>, Jan Kiszka
 <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, casper.li@mediatek.com,
 chinwen.chang@mediatek.com, qun-wei.lin@mediatek.com, linux-mm@kvack.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/3] scripts/gdb/tasks: Fix lx-ps command error
Message-Id: <20231129141542.56d76170d38f2f6ee6b9ece3@linux-foundation.org>
In-Reply-To: <20231129081009.GF22743@redhat.com>
References: <20231129065142.13375-1-Kuan-Ying.Lee@mediatek.com>
	<20231129065142.13375-2-Kuan-Ying.Lee@mediatek.com>
	<20231129081009.GF22743@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Nov 2023 09:10:09 +0100 Oleg Nesterov <oleg@redhat.com> wrote:

> > Fixes: 8e1f385104ac ("kill task_struct->thread_group")
> > Cc: stable@vger.kernel.org
> 
> Is it possible to merge this simple change before v6.7 ?
> Then "cc: stable" can be removed.

Yes, I shall do all that.

