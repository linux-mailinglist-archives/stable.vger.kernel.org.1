Return-Path: <stable+bounces-253241-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHjdMucFDmqv5gUAu9opvQ
	(envelope-from <stable+bounces-253241-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:05:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A32597B58
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 243D832BBED2
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C61421F12;
	Wed, 20 May 2026 18:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ctTuXHwj"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com [209.85.221.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44731409617
	for <stable@vger.kernel.org>; Wed, 20 May 2026 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302766; cv=none; b=d1/hq4hS1JtmVqr/v98OCIh3GUAvlLnAJvUXI/XI/GYlMC0vgdQBvnCer3VDc05K5V9KiWB1jyjpaSnGIgIsnUu99gHl8yc7C3Stoe41zNOVdgqN9n2z/Xy6trqqYp9p6JrXNP4d/eanrvY6fz/eI5mpQhFEl2CdpUxknZGWDUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302766; c=relaxed/simple;
	bh=IEgOhX5mSlGgMwF6CJs9QGBb5c//pY837CoFBbgWLjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D1/0jD7e95ND60i/RudziUIoaRmEqp6ImpbnvMUMNcMB8SA0WkJHn8lybCKmz805Q92OmntvuMnANk0c7KnEbIfOQMyxkFzuBNQqLaI6QWLOIbBOGTG43Cdi4iwO3g+hKa0y5KZKj7ZAP9qbbYoWOTy4bHeIgQ137dNLjAHW7Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ctTuXHwj; arc=none smtp.client-ip=209.85.221.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f226.google.com with SMTP id 71dfb90a1353d-5751a9020faso3971464e0c.1
        for <stable@vger.kernel.org>; Wed, 20 May 2026 11:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779302762; x=1779907562;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yz8WNPTLivvf8aO0NCQc1Y4S+bsvggq3/xlwaBZWzOA=;
        b=QKQdEw8yhF8iC77ROP9ruWZvvmjyLY0G5CJiip870B18GROYedPJMTG5ZV3HX9odBX
         Ogb4ZwLCpx+vs3CS86FJve7di/YxLiczmz/Nh4bz/AGI/9rluHRvO0x0ikQWvHxK4JPA
         2aSMPH8QKFmcC17SuDLvNG+N874dF1HbNugAUarUym5EeVuYV0Vb8IgpUPMsGgAOM/WQ
         2SOLbEcj6ZLQD+OfL1C8RQubLhuSjPV4hkNQjo+GEgMJ2BbJz2Zxt/vmiBA8Hnyla3Bs
         dLPW1/T6fyEARGRsl9jDJfesYXziS+Fr6KY+jqevNOKbHlr9AqX8GPcBrBXhK6EMWbyU
         pA4w==
X-Forwarded-Encrypted: i=1; AFNElJ/KWCcPQdUcudM5JQ6bnzGbQi/mqIsoXDQuffxdDNpx7rgtZE3gTz11LKek7VztbecSS5hCvmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdJew1p6auGJg3fV6QsUR1hoynUiCSKUx0DBgVeQgffIcKvYMx
	j3VjF6ebYCo4X+YqWcchYbLQAeMDQyW1Jhf/pAHIVwWu32RGxE62i4WHupBbb2bsKt9kGkgXlCF
	16jOkBCpnGUa9ouyHlytIESWgSNxp7T1rXeaHnvTp7TOo34UzvZ+226o+BWbZqzfYKep0y7q9oa
	bqAcIBsp+nByxJ0U+4onPhWXmdMHmfEyO+x9d2pcX4eZL9zXaZ9eX4bPzenPC+OSOkIWkvHPaWt
	xozjvthZjAyeSBp
X-Gm-Gg: Acq92OE1PGJ5lgaCJ/6hhV2eu+HPZK0m0TsH+z7E66qyTmJgHQYoPobbM0hW2b1/JES
	JbApqnCgp79y9o4DxIG2HMl3lfRxH+sViA3zJSrdIQIADNGE9Y9q0Wb9aoLk1oqzRuwPTZTfQfr
	phQnE7NN1x08YCGhqwI5o06BpsFu9fNkawQdhyEjBzaEzjyWmU9e3BL5kHh07IxZ9HkY1fQ1GeJ
	EWT07pKKus0SGvuTfJmLTLeSUtjcNFXlY8eQF+eD/sbZVP2qP+5uFC0zzN2k+bkv4HKAyDPcdQ7
	a6+qOaexkTsBn59TGOaTkxJDy6IZbfvAd6lUnuk2qZVH83Z0YJmYFhO4GYY6KtOgMfjLwQmNpQX
	JL2faj/TFcG6chW0IgdvvkBnO6SCNUWAL2Y9RNLrHcC8UrauLDCiPsY0Ax/JY1HKzI5PpHbf6y3
	Nvda+cW3CPwKepxs6JWHkIk2ZNObcVkb03usbi9ZFPQY2xZybh0fSKssZ9QUaqpw==
X-Received: by 2002:a05:6122:d02:b0:56d:2ca7:fbc3 with SMTP id 71dfb90a1353d-5760be86bffmr13887927e0c.5.1779302762456;
        Wed, 20 May 2026 11:46:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-95fc2f17d28sm792087241.5.2026.05.20.11.46.02
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2026 11:46:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2ee1da7a13fso6411974eec.1
        for <stable@vger.kernel.org>; Wed, 20 May 2026 11:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779302761; x=1779907561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yz8WNPTLivvf8aO0NCQc1Y4S+bsvggq3/xlwaBZWzOA=;
        b=ctTuXHwjiEwLHDYK0cmw9W7MsHzoHq4SxYuF5718RCg8h53xzdyt/KVbgW6a1kQcx6
         qGnfUo8n7YKn+WfJU2qFuQO4hc6sOoRfuNhG3mCJ6zX37xqMDW66iouGNWQSyxv10UQW
         9kBkPvCxjAYEoHl4REQvFEhY7EwVxv7taDxxM=
X-Forwarded-Encrypted: i=1; AFNElJ8ZLLH9o/ssIFdSsqK2gQIigcks+uhXrnDebUfHuTnkexjKfZZz8vB5mQGnmjlNZJjXt1EoTJw=@vger.kernel.org
X-Received: by 2002:a05:7300:5b88:b0:300:255:22cf with SMTP id 5a478bee46e88-30398652e7emr12183207eec.28.1779302761067;
        Wed, 20 May 2026 11:46:01 -0700 (PDT)
X-Received: by 2002:a05:7300:5b88:b0:300:255:22cf with SMTP id 5a478bee46e88-30398652e7emr12183176eec.28.1779302760431;
        Wed, 20 May 2026 11:46:00 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304052f79ecsm6188546eec.11.2026.05.20.11.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 11:45:59 -0700 (PDT)
Message-ID: <59df32fc-59eb-429e-aca1-2c5a64c988fc@broadcom.com>
Date: Wed, 20 May 2026 11:45:57 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bcmgenet: keep RBUF EEE/PM disabled
To: Nicolai Buchwitz <nb@tipi-net.de>, opendmb@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: justin.chen@broadcom.com, phil@raspberrypi.com,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260520184320.652053-1-nb@tipi-net.de>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20260520184320.652053-1-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253241-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[tipi-net.de,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 71A32597B58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/20/26 11:43, Nicolai Buchwitz wrote:
> Setting RBUF_EEE_EN | RBUF_PM_EN in RBUF_ENERGY_CTRL breaks the RX
> path on GENET hardware once MAC EEE becomes active. RX traffic stops
> flowing while the link stays up and the usual descriptor/RX error
> counters remain quiet. In that state the MAC still accepts frames
> (rbuf_ovflow_cnt keeps climbing) but RBUF no longer forwards them to
> DMA, so rx_packets is no longer incremented at the netdev level. On
> some boards the corruption ends up as a paging fault in
> skb_release_data via bcmgenet_rx_poll on an LPI exit.
> 
> Reproduced on Pi 4B (BCM2711 + BCM54213PE) and confirmed by Florian
> Fainelli on an internal Broadcom 4908-family board with the same crash
> signature. RBUF_PM_EN is not publicly documented.
> 
> This shows up more often now that phy_support_eee() enables EEE by
> default, but it also affects older kernels as soon as TX LPI is
> turned on via ethtool, so it is not specific to recent changes.
> 
> Always clear RBUF_EEE_EN | RBUF_PM_EN in bcmgenet_eee_enable_set so
> the bits stay off across resets. UMAC and TBUF setup is left alone so
> TX-side EEE keeps working.
> 
> Link: https://github.com/raspberrypi/linux/issues/7304
> Fixes: 6ef398ea60d9 ("net: bcmgenet: add EEE support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Thank you Nicolai!
-- 
Florian

