Return-Path: <stable+bounces-132650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADEDA8894F
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 19:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BB2D1893F17
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 17:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECECF284685;
	Mon, 14 Apr 2025 17:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tzxPRS3k"
X-Original-To: stable@vger.kernel.org
Received: from sonic310-43.consmr.mail.bf2.yahoo.com (sonic310-43.consmr.mail.bf2.yahoo.com [74.6.135.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCBF28468E
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.135.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744650319; cv=none; b=C3wEXUWYZhiY0ME+dwoc6wJ4EItGb1xZ/RBVAF3uBGMmFu+l5Aj2fFcTV7xqGWC0fcc/sTsF+ShONDSDkLXJP29Pp1YxT8E6wwBrexQ3FgSmMip37n9II/RQgjo724QVoOlJ8B0Ng1lDAMD+zTop/JM/5sJpOW/7fIrwgg1sSBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744650319; c=relaxed/simple;
	bh=LRip5C8YXBMcattS1GRTxAuDuczRlbVQDGWhRq42ClI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nqmtk3tP4A/XoFt86s03hJZONdUp/neLYoWxFxVyuZXYTiBR58YYKgIKfoT9yXR8q187oDNQWWU3XiE15Y7E72EdV6vIFfa0NI6zR3cBDxGRGV8oyEHkP4zym9u07v3JL+mo2x6Mmpx27BKwwYGPT1Zsq4Ewj8MtvEdvfrhOn5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=tzxPRS3k; arc=none smtp.client-ip=74.6.135.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744650317; bh=6V04kO3rpZ47EWD3X905dHz9fGQ1xlrcbJbLzzJKDj8=; h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=tzxPRS3kXUVdNTHDgTXYTcelSzJGjz+iqFFSpAZl6V3pCacZhRvGQXsXomrnTwxspDMSaVA+llORbsiXKuS89Qt5rm1ZkDGwRHFFvzm12+/5P3zQBfHwkcjBFpZcPCh9Ynr9CfqfdgD/hGiS5BjoQ3BXp7U2OOV3Tigg68rMTpD2/rl1KCpbEazyAE/ev+rctUm22iXilKR8mux+2+8N9eW/gK0fwbt3lElk0m47ovEGweFyhMVM0B2q92xgAn00c+XK8ncSjNkrbOA1z4rNgjm8Vo8wTGm97p5ESHX7JqGTutNiS8Sg0En0q7isTSZROTJ9NOqpDdrC6qMuQ6FJxw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744650317; bh=Lcx00m5tbRksXTnpQMgU+RugvKxPHXCTE+aeV8TBh7y=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=Mc8TdyAYxRL8rcgm8CEJULblzEk2+tBrv0qh7Mjf65xBIDoHg/+V0Wc4STqFfj6yK72YqyF3Hyizc/FiG2I5F8GApexOxu64pD2iaeK4aLCzs3GByEWtEF1YjM52qii33js05oxP47SN0QYmDgN19/18/Agog5ZgIxG7Se8PW5/cFMRXmXrBCqbNAmXOYKr0aUJ5De6kbMpzsBAZ5jIjvB/vDOGO+vd3M+CLw1Qn4qBVWqsIYWhOwZo6CSZFNYVweQW+PAQhY2NYiJEsCZBQTm0NRzFlIf05+UNzgCMtOOtj/VF9WbxyKbSJzEkH/hjZhKOShZSD9O/dswRp+M+vsg==
X-YMail-OSG: ijaescAVM1kj5AFBIzzT.YKhGnW2.GMXcoNbQi.Jna0FItqIw5ZmuNjyO6y4WBL
 nGAdxWYqSBtPW7w6BJi3kQLTHkYS0Fyt5OKIJzTo255iMyr5RfZ0F2qquSlJh0LoiU8T3eiul4tE
 9K3BMCQf93_hzZCVBcXw2c95HyrFdn4XqOj1QRRS6IhnQObkdTwv3D1bmKADOU7eWlI3UKO.9tYY
 R4TYDbz9rwrZaepSU1349IKr1S2Qu3guonNuts1Pj_jG6Faq7DR0Iwrz2B6BfxPgBGTTdU77q.tv
 8Ivhly6Bt82znn7SANBbhGhnHcjy_En7BAiLplxZPK3WIyGzV.Z66T8lMlMHoPyHuujr6XUB9WGi
 kLVY7VQ5MV8mLaT2kz5aRz0DRRpi4pM8bXVYilFTujbdkgebdsnSOoaC1LlCKqBXs3VktflfFgSN
 CCmFlAqaf1.vOE2zxeXJhHSNWG2aCSwdg1whgQDKAEvRKgQwxhAmbsLsGCEmIzu6PTwQxA3Rc4Ij
 OWrMnMhLEyaUAYWIO4ZAmuJ1xxXJUuauhX2aEKKnOnjnyKbSpuRVz_94gDN5ZHmAPZCc_5IgU7x4
 BzG7FpRA4amT1lhVjCqcGoQsUrxz1CeUXNivlnRhdokeNHND1KyqMMJ5Is9NqiV5CxkhIrtv6GtS
 hXsc8aCSr4FCbuc6vF5nI.eRPFZSN5lGDEBhbwdA3JR9QVqTODNcAglR498sijcdqVYCA.xzFj7s
 xdNwP5RSe5xRo7thDmkzRSjYSEF2S4xpDqtLM84SNt_Q4QIh2ckfp_eSfxP.aUxmQYLBCgpbvIJz
 ElllqXu.JdgOmDgXmlH0J_vKlxNLwooRNuUnogEN.ATpAu26KV2ID9aqjtVGdGjK55MfYU0teetL
 XA9EzdzkU3etTnb2lAEW1ebexZwiZlfxPSNUFRs01hP4Tw53ivColKJhxFD1f74kEefmVfQyCJXS
 aCVbsRiWlVYWyt6DWA.YY8BSIE6s32LCrlVS.JlLi80lNSapZxeKkYPrfgCra.0SprZfe1XhPKEV
 aKKW0zCa1IWqqY8hUDN.Uz.Ov4Tik4iwkJjWruy4u5hBWno.Az0b9F..xVj91vfZ37JI2wMCkSfQ
 Yt8xmeGZaL_o_UcLLaNpkHIx6D616F5hOxo0vZcNRHJa5.zDEZPgY0ErKtwxI7yHvXxbyh7C30Dr
 dPBVJQRTZF8XAuoIWbnDFh.SfWICdopamHEdFnV6Qp485h0Q6hvAzyBBB_.geAGdIm68d4rO5h2Y
 M75NWavibJsQWCQ_j4ZoRSn8T2Ztn_3yI6HcIJh3Q8Gu2RpuQBF8jEqiZGNr93VaVio4Ev3tF2X3
 ap57Wu3p0uM6UssZqY5QdAXAdtiLYCHbNj_ybVALCZN6kU1.ptLZSjArgE1kI0pMqMzwSuajpp0S
 _wS3nRptlINDwD78V2tBeWQyhPFqOY4YHWU7JNlS6WA7Q.WGuZJyE6wO8zYIs42JimYDcMdreOck
 6zr.6R1hwsP0oIBcyJrz2zBCfVYHsSyR_0e17Zec3kEcWIOBlWeuqegwyZLabUkOU1Vpmdlupx1V
 Kz2fL9agosZDxRAk6k5vHOFQ9YTLTNHYMtvBJ2g3c3DEsqOPalQyG2S7fd.rMcVG7xxWRVfCB.AB
 6U.Sn8VklpY4dcK1n7NBBJg0Ro6OmfnvBxc1bezv3Gt_NjUlIHD.ouh4tP28bhu5i7i8uSTIof8X
 Y8K9RLR0OmEDIj3_C431SxQ2IZhKWuBwBNtoRT_Tz8vFg36k2BF0x.wG482p5M9G_waTKw5QBnrY
 PV2hx6ZIaw0cUcoDxBeAiLtRENKoOhmHIEUChWDOpK.KWD5n2fHh4XUc2M0rbzNrpRXVNHlcLxaz
 8RQ4X2ay1lT3JvRnVa6.bSajS21qYnVW_B5.npCmkS6j8Gjy0G6FaeOxsPsJOSLD2teUZRPG4vNZ
 0x7enlFk1mvGEdGmkL6yLsiL1_dOiujje.akjTuY3gMuzvn0iuoqBEpEdgYIrL5PW2nLw_mhg0Di
 BODDRNa.BCPpewEfzdGzj9ytsSG6sq3UH6J4gfS3E3eIxsYP6ebawE7oR6VOp13Nvl5K3FmrAizb
 Z2UC84hAnQbtOw8FWFmEx20M2VRbXwrUr2c6lDfO5OVdQIWGaTzrizOeOXR.qQsB4qVDB0aPVcrD
 WdYVqj25OaxfI.cSPKAFQssdVnUjnxie9uSdhHsEkWA6DhhpphGZ7sxGIb5KMDZn0m9QC_wo6zp5
 UCE_iAr29sp4JfrkfixrANyuNhPZeJ1CwYGA9OD69mgFTgKl0Wu_ZNwS0L96wtjsRZOBVLjou5p_
 gVzxzbi8m2ED32Ql8BTFHvBi2DAXzQDnybLfiZN5Vb.An
X-Sonic-MF: <dullfire@yahoo.com>
X-Sonic-ID: fb281f51-85b9-4bd8-87a5-49c0144f821e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Mon, 14 Apr 2025 17:05:17 +0000
Received: by hermes--production-ne1-9495dc4d7-vqjq6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7de9b757f65aed43fbd0bf15ec9cf014;
          Mon, 14 Apr 2025 16:22:47 +0000 (UTC)
Message-ID: <3aa3b1aa-84c1-4bdd-ac79-918bcd80f98b@yahoo.com>
Date: Mon, 14 Apr 2025 11:22:54 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI/MSI: Add MSIX option to write to ENTRY_DATA
 before any reads
From: Dullfire <dullfire@yahoo.com>
To: Paolo Abeni <pabeni@redhat.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Mostafa Saleh <smostafa@google.com>,
 Marc Zyngier <maz@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20241117234843.19236-1-dullfire@yahoo.com>
 <20241117234843.19236-2-dullfire@yahoo.com>
 <a292cdfe-e319-4bbd-bcc0-a74c16db9053@redhat.com>
 <07726755-f9e7-4c01-9a3f-1762e90734af@yahoo.com>
 <4f621a9d-f527-4148-831b-aad577a6e097@redhat.com>
 <5a580609-aa5e-4153-b8dd-a6751af72685@yahoo.com>
Content-Language: en-US
In-Reply-To: <5a580609-aa5e-4153-b8dd-a6751af72685@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23665 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo



On 1/20/25 6:38 AM, Dullfire wrote:
> 
> On 11/21/24 04:28, Paolo Abeni wrote:
[...]
>> The niu driver is not exactly under very active development, I guess the
>> whole series could go via the IRQ subsystem, if Thomas agrees.
>>
>> Cheers,
>>
>> Paolo
>>
> 
> Thomas, does this work for you, or is there something else you would to see in this series?


Since it's been a few months, just wanted to give this a bump, and see if the series is lacking anything.
Thanks,

Sincerely,
Jonathan Currier

