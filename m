Return-Path: <stable+bounces-78387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8BC98B905
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 12:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3B26B214C1
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF4D1A0732;
	Tue,  1 Oct 2024 10:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T26ozhoF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947191A0706;
	Tue,  1 Oct 2024 10:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727777558; cv=none; b=k118WHY5rmZYZx1nn0cKhaZ2CF/duL0WfvjH+H7yPh/iXWN+y3pnfQAJjbuRQ6z3B1JK4htdm498WCGhcBvDLCBOATmr14QWxJIA41ZIkNzDK9z7/xo0ipbA3tvWl/KirYjeS9kVz1VmEFbBo6t7KPR+80bOKRMAJ44rwPH38O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727777558; c=relaxed/simple;
	bh=eMQfwbeuxjeGz8czwVHpYthf5K8I7DXdKaQYgdXolNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k61Sx3sOLP/cs2qxaT2iO0z3r5XYslmgQsxihhdjEXpHOrGKetv2goMG6/AkcNb4N/H1qVY1+Vayuxma8t/gVbQtYb5OF0EjGKq36f46G86v6nRCieGfc3XG/UVUHSyvMysclNB/ViFvsMsy7Z78UAsxOEQcyJQ8vKjtpB6H+lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T26ozhoF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38B1C4CEC6;
	Tue,  1 Oct 2024 10:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727777558;
	bh=eMQfwbeuxjeGz8czwVHpYthf5K8I7DXdKaQYgdXolNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T26ozhoFGcSnBuTzphtCnVke2qkLJOFPqtFAxMBa2/CWpZ3rw00f3SMQRRyAILRmi
	 tKtKNxBFdT8Pm1aeVmVOX9cxbYaWWpLnVqhizjh84CDwvV/cLOE6kedRvtiPXoqaa1
	 uq8sPwbygPSDyKDENH3EW97yV2moU83TXE1ie7GQ=
Date: Tue, 1 Oct 2024 12:12:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Sasha Levin <sashal@kernel.org>, Bibo Mao <maobibo@loongson.cn>,
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
	Xuerui Wang <kernel@xen0n.name>, stable@vger.kernel.org
Subject: Re: [PATCH 6.10.y] Revert "LoongArch: KVM: Invalidate guest steal
 time address on vCPU reset"
Message-ID: <2024100122-wince-acquire-dc0b@gregkh>
References: <CAAhV-H4WLByJ53oqQgEnVjy4bT0pS77fT5BA4NaCp8AOn+cyJw@mail.gmail.com>
 <20241001085521.102817-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001085521.102817-1-chenhuacai@loongson.cn>

On Tue, Oct 01, 2024 at 04:55:21PM +0800, Huacai Chen wrote:
> This reverts commit 05969a6944713f159e8f28be2388500174521818.
> 
> LoongArch's PV steal time support is add after 6.10, so 6.10.y doesn't
> need this fix.
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Now queued up, thanks.

but really, this should have been "v2" :)

