Return-Path: <stable+bounces-176974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D102B3FC51
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 12:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39B4148721E
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 10:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A57283153;
	Tue,  2 Sep 2025 10:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="pVlrV1x7"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC10280CD5;
	Tue,  2 Sep 2025 10:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808682; cv=none; b=mIDOiPbouGL9Thi1DxiDWlY/sXalCu2tmxa8w/tikrDwrVt2Z9Fol2E3ONCPDW0gk1EiI3C/1n6at4L4V+fJxQoxs3f0Vh51oEph0Qbf5rAi71H46PFBsIORiOJplRJCpfeqKtnV8hg9Zdg9tnCzf60HOQI18jpwyMf5fprNub8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808682; c=relaxed/simple;
	bh=UYdqZmSvIMsuh0gQFSbMczX8fEqJTCM340sWe/Vk1EM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=jobNaZwXtdvH2NcMRbqHcISf3qfhMyvueJDNhStFmQNR2rE2/iQ0wFKKOuTvJbpB/zVpXxVLLfi7tqelAjhFPlkaUpNsXDvvprGLxMwwCfMG7Jg2V08Zt61Y8lX5b41Fq59gvJhbSVXa4UlL20MDpbdscC6jNilE4kp4R/P/Gkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=pVlrV1x7; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756808654; x=1757413454; i=markus.elfring@web.de;
	bh=cjJrnkDnFnzLDq07yvkm48ap++PaOM5ISCnzNbnsPRY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pVlrV1x7N4WYliOOJXt4LpRxTREoWqQn6rga/Y2/Ld4QGK93A7BLdSjGN/xT0TCs
	 gCXrlV51oBN9SO6TJ0Cp80sJBOSUQ+m7RQy5DgaF88tMVWM/OmZt4HyMsVtikKVk+
	 Qh9UnHDgWCq6CuCHE3+1BciGHCAqA0VBRvLJoJgmx+GYJEAEJzArVMXAkC15RiZxd
	 kktWfGrF+8zNLBj6oxcEo853+PCzFRjjT0QYl9agdedeF9xxAH5Se3Y8s5Gx3FW9Q
	 WEg1eV7I4oAk/ztsLsvc3V6FOxhP15ukS//8s5X+7uXqTSWN9rt22kKjAmYhTMxb2
	 WOL8FWAJkpvZTT81jQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.184]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MRk4s-1v3oZA0gW2-00Roqf; Tue, 02
 Sep 2025 12:24:14 +0200
Message-ID: <63be79a4-79e4-47f5-a756-aa55fe0d29ab@web.de>
Date: Tue, 2 Sep 2025 12:24:11 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Miaoqian Lin <linmq006@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jiri Slaby <jirislaby@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Olof Johansson <olof@lixom.net>,
 Paul Mackerras <paulus@ozlabs.org>, Thomas Gleixner <tglx@linutronix.de>
References: <20250902072156.2389727-1-linmq006@gmail.com>
Subject: Re: [PATCH] pasemi: fix PCI device reference leaks in
 pas_setup_mce_regs
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250902072156.2389727-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LEf6BUZ69GRHnmo0O2buQynr9kYKhuNh5K8eqeJY7X82uuO2Qqf
 5hq/Fq8jQ28bVPFR482bOpqIVsrWey9UIOw1a4TDAv+1oId1UV98ADFoOTo+jldZVBZzqDF
 JktM38rq+o9Xle/9EN/5RxIMFCRDq47/edtb4tgqaJQQ0mwSfarLvNihLinUG77nRFfBbUx
 nbh99d9cHzKL/2wtROBzA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+TxOwPhxDCE=;F2qSg8NLdR6q7NdR23j5QHM//Lp
 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

=E2=80=A6
> Add missing pci_dev_put() calls to ensure all device references
> are properly released.

* See also:
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.17-rc4#n658

* Would you like to increase the application of scope-based resource manag=
ement?
  https://elixir.bootlin.com/linux/v6.17-rc4/source/include/linux/device.h=
#L1180

* How do you think about to append parentheses to the function name
  in the summary phrase?


Regards,
Markus

