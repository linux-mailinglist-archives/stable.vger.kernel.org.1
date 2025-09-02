Return-Path: <stable+bounces-176963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C182FB3FAEF
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 11:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41BF21A86C05
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 09:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513972EC099;
	Tue,  2 Sep 2025 09:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="HvS+sIhx"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE1D22A80D;
	Tue,  2 Sep 2025 09:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806259; cv=none; b=rBF1VBNuXqOFhNHOafdQ2NiwfoEHQ74a0sZzO3qk8CG9kZpOaX0LXAaTjXeXVmCCRIJzVIyFWYBvAE9oO8+IwhSCZa8YdR9BUGu75l8cdZs9IiKVBdRy2Kzx8aqHkE/+gU9u16ybLZ12VMDyuVWKvS5sn19xL1MUjLVrW0OFS64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806259; c=relaxed/simple;
	bh=lGnjXOkn1C6NLSyAP8y0/XgunBF7nt5jXbHT3aE7N3A=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=N3nyPI4JuSoR6E5mKtQxYFtJRBoOVQiYdKbARmMHa8fmJA5qobxemLCH+CYgrzcfcmhqbJUNT8cwuL2DoVJezuTidYPc9yQKNku+j7VBzHx/QyCBeq5gFThEwB1xZkh52O+/Vwpk1OZ2Pl6W3OB1CEA0zY/v059awSO+9KD8yAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=HvS+sIhx; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756806252; x=1757411052; i=markus.elfring@web.de;
	bh=F8B1yWdizJJfpSjkl+eTICo8nrCLYseuW1pRz1FscXY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HvS+sIhx/aZtecT9M8MyKpKg25L7DxkM4zX7sZOcEmzth19JTPIqmOFqycPpwzIy
	 jpbfuzfRl4CbgiFxICwhO+awoS6SKFuoUq4q2iUMnYhLVc2vsQ4R1Plnoh1TWBjnO
	 oxdDDlM6Yu9QwLYDGWVu3e5bHpVbOqy9vZJOJ5KT3CwUqEyT6bf5a2HttP7n8PJfq
	 KKILql3++SepE/drpFXda50o4AKjcNzAcBabXnJ4UQwYUOUIvZHq0GL2lCtD8rkJO
	 ni9P1f96ncdlzbMw+KC+0E+dyccyQebySi92FG5O1HrIdIg3tfh7bZ09dSvBXzVcF
	 dDaOELZuMQ5ySK/34w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.184]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MyO0u-1uYNjb3dUK-00wBsd; Tue, 02
 Sep 2025 11:44:11 +0200
Message-ID: <cbda4163-6211-4c81-be99-634b842a349a@web.de>
Date: Tue, 2 Sep 2025 11:44:10 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Miaoqian Lin <linmq006@gmail.com>, kernel-janitors@vger.kernel.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Nicolas Pitre <nico@fluxnic.net>
References: <20250902074353.2401060-1-linmq006@gmail.com>
Subject: Re: [PATCH] drivers: bus: fix device node reference leak in
 __cci_ace_get_port
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250902074353.2401060-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:NSr2io1GhqKKijv4n//GlniSWihh47V6+b2pZ6anDYQzBbcLG6K
 L7ZrNp1VFyvFDsSNjWRIwaiRPWgGqQLFgosnaTiqudyYMmNWLv5jn2z5f1CMBI8a03w2YMe
 Rwp17XaVpdLFLkX+6XWlIBN0aooYocZ4Gk5AC/Qxivw/m+0eU1fTo/GwHkmD+C6bDrle30h
 6mfwVIHpOCGFDzW5G3++Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:919U8jMIOq0=;Z+lLCHp+ne5ZJPf2ysVLi6VXrSl
 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

> Add missing of_node_put() call to release
> the device node reference obtained via of_parse_phandle().

1. You may occasionally put more than 58 characters into text lines
   of such a change description.
   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.17-rc4#n638

2. Would you like to increase the application of scope-based resource management?
   https://elixir.bootlin.com/linux/v6.17-rc4/source/include/linux/of.h#L138

3. How do you think about to append parentheses to the function name
   in the summary phrase?


Regards,
Markus

