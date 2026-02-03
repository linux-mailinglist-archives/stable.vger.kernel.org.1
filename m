Return-Path: <stable+bounces-213190-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ByWJl7NgWl5KAMAu9opvQ
	(envelope-from <stable+bounces-213190-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 11:26:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5C3D7954
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 11:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 118FF3073D36
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 10:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F06318ECD;
	Tue,  3 Feb 2026 10:25:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFA9318BBF;
	Tue,  3 Feb 2026 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770114334; cv=none; b=J2zxnPf+8CcLVwCJ5wmo7mlHN7TT7jx8OaGrRaF1HzespjgiHUwPqjw1pIWZUgoq5dBe8rvkcfeIHcTY4rK8NQ+PDIlD/+hpq+7xMCi9DdynM9thzdCZl+Y012QsZ6P8PQLXvSVM3gXdn6/5IAj0BJ8VcrAA0nGLALDJVegXPUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770114334; c=relaxed/simple;
	bh=nMGX7xeEQFNhbtXWP5GAYHCvliIXmhjiDA4x3qTC8M4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BcYr1RpE7YPWW00Q+dD5sjtQnyKuVZGSn1/Sw8YF03EMQMJe+vDLD65CGQxuz2H6H2Gy6zkt6CUwXdqzxO9YvfbANgzxfBz84k1IHrVAagtR9O7clGlIHmWb2E2NzZmljZZuHDyi5ZeW4Uc1UWMGkC/ovvENacY+QAkLRE8INkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [10.213.18.154] (unknown [210.73.43.101])
	by APP-01 (Coremail) with SMTP id qwCowADnjmoKzYFpPVoSBw--.2286S2;
	Tue, 03 Feb 2026 18:25:15 +0800 (CST)
Message-ID: <140cb690-caa2-4c94-8b4a-75c0d89e2056@iscas.ac.cn>
Date: Tue, 3 Feb 2026 18:25:14 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: spacemit: k1-emac: fix jumbo frame support:
 manual merge
To: Matthieu Baerts <matttbe@kernel.org>, Tomas Hlavacek
 <tmshlvck@gmail.com>, netdev@vger.kernel.org
Cc: linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dlan@kernel.org, stable@vger.kernel.org,
 Mark Brown <broonie@kernel.org>
References: <20260130102301.477514-1-tmshlvck@gmail.com>
 <4819ec3b-23b4-447b-b10b-0bd93a40dc5a@kernel.org>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <4819ec3b-23b4-447b-b10b-0bd93a40dc5a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qwCowADnjmoKzYFpPVoSBw--.2286S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYh7k0a2IF6F4UM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j
	6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gc
	CE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxI
	r21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87
	Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7Cj
	xVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_Jw0_GFyl4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcoqcUUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213190-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangruikang@iscas.ac.cn,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iscas.ac.cn:mid]
X-Rspamd-Queue-Id: 0E5C3D7954
X-Rspamd-Action: no action

Hi Matthieu and Mark,

On 2/3/26 17:39, Matthieu Baerts wrote:
> [...]
>
> The conflict has been resolved on our side [1] and the resolution we
> suggest is attached to this email. Please report any issues linked to
> this conflict resolution as it might be used by others. If you worked on
> the mentioned patches, don't hesitate to ACK this conflict resolution.
> ---------------------------

Your merge is correct. Thanks for handling it.

Vivian "dramforever" Wang


