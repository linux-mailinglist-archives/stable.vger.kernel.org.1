Return-Path: <stable+bounces-164736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EA7B11F20
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 15:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B92775860F7
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 13:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23EE1531E8;
	Fri, 25 Jul 2025 13:02:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF88139D0A
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 13:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753448548; cv=none; b=IAqAKxeQJsAszOWppjyFBXGG6yLwfxp8498sqmS77LvfknK3Kf2l1iz052X+3p5Qiyua75Y5KG5FsOsWK9AcxBZb7KRw1jVTKxPHSwszY7Dej9iloceWvM7HBImXL/yPAa9/pFIdgM5BCjvnhCzskVd1WIm5eCBeS1539DDQZvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753448548; c=relaxed/simple;
	bh=k+xoCBkTA5T5FFwkHdqsBaFllzPXdJqeA6nWuxd81lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfrJz/FEDa2Uju8BNA9qdPdx3nmyVl3sGoFnIhinjYOpgcQh3K/uBoi6ejuFbH+0TwgnVCkgZXyIoPlfXeSiXa60Iflfg00Ab9ZthD8ZCOJ6zH2im80NG68OZa+MuLGgPVOTI4kHF46rKyrdKbO959E56pnQjHYZZI7RjiUQ/ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [223.72.91.65])
	by APP-05 (Coremail) with SMTP id zQCowACH3l5KgINoNwX+Bg--.20513S2;
	Fri, 25 Jul 2025 21:02:03 +0800 (CST)
Date: Fri, 25 Jul 2025 21:02:02 +0800
From: Jingwei Wang <wangjingwei@iscas.ac.cn>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
	Alexandre Ghiti <alex@ghiti.fr>, ajones@ventanamicro.com,
	Conor Dooley <conor.dooley@microchip.com>, cleger@rivosinc.com,
	Charlie Jenkins <charlie@rivosinc.com>, jesse@rivosinc.com,
	Olof Johansson <olof@lixom.net>, dlan@gentoo.org,
	si.yanteng@linux.dev, research_trasio@irq.a4lg.com,
	stable@vger.kernel.org, alexghiti@rivosinc.com
Subject: Re: [PATCH v5] riscv: hwprobe: Fix stale vDSO data for
 late-initialized keys at boot
Message-ID: <20250725130202.GA53568@iscas.ac.cn>
References: <20250705150952.29461-1-wangjingwei@iscas.ac.cn>
 <mhng-2F811C61-A512-4742-A00D-7D01203DAB14@palmerdabbelt-mac>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-2F811C61-A512-4742-A00D-7D01203DAB14@palmerdabbelt-mac>
User-Agent: Mutt/2.2.14
X-CM-TRANSID:zQCowACH3l5KgINoNwX+Bg--.20513S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYh7k0a2IF6FyUM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j
	6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gc
	CE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxI
	r21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87
	Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7Cj
	xVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_Jw0_GFyl4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2JKsUUUUU
X-CM-SenderInfo: pzdqwy5lqj4v3l6l2u1dvotugofq/

I plan on adding your Co-developed-by tag to the new patch. Thanks again
for the help.


