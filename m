Return-Path: <stable+bounces-232949-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDNwMrkyzmkpmAYAu9opvQ
	(envelope-from <stable+bounces-232949-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 11:11:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 276EC3868CB
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 11:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AD7C30DC8D9
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 09:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952EC3382DC;
	Thu,  2 Apr 2026 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="j6IVug0b"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C53314A79;
	Thu,  2 Apr 2026 09:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775120734; cv=none; b=XG0ADEjDCktljnnWuMY6PCZMUIlYlKcsGL961vySDHFyf+NIEkjkYcxptCCdgD9Ywdg/IF6voPwutwBgCkJgRgZ23FOn06/EIywdC2AIOQ9kgMNuW/PCTOJzrmypzhE2fQCpZQA1gMdbMAFlSnTh1OtipmG44kvpeTdgmQ6WNFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775120734; c=relaxed/simple;
	bh=ACU06XcC2AdGJPJInp/+xeayTUorb6bPBEad21OsdSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rq8JkwCeRV/gEdQHD2B+sutMt98BFSu4YAgfQddErgoDcBPLEQ2hkFsDc2ipbIm4nc5ss5hjQfHzLAcUdZaco5aZcN3NX5HrKkq5qqw9gxYvDkiKAlUd7DqT72N7xbVUHscxQoqpF4Tx1q0NL+rDqWYCd6pOTcWBuwbQ4aLY5FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=j6IVug0b; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1775120725; x=1775725525; i=wahrenst@gmx.net;
	bh=ACU06XcC2AdGJPJInp/+xeayTUorb6bPBEad21OsdSA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=j6IVug0bT9DLRaETqFs9nXoLzSu70qDN219af+Kt84NEo7g2R9T9E0nAZtbZmsgR
	 f4f4QhSSHn5txX5EKa0vBAS64vUB7FqfMUAl413c0lQYLcDnAvS8cIOwIe6/E0sGb
	 1Adsbxkwb/xl6rR3bWkyNG2+mPpcEfu3sAPyNsEBX0VOVfjiV5h4dwuTIy5/6Bbox
	 jnaw1WR2bLRJTlUJLeUzafTAG3+jiKxkBPj0MPAYz3MC9wdsZ4YFNQMAPv4S37Yz6
	 NHi523/Jwfs3cCPQI0flDU+p4JgtPq3Il8IVdRgoIY56THLLaVRumH9spULioBMmq
	 3S4Te6cHlO7JCddSOA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4JmT-1w8UyL49vl-007hlG; Thu, 02
 Apr 2026 11:05:25 +0200
Message-ID: <d5fd9dce-549c-42b9-b1d5-ffec41664e48@gmx.net>
Date: Thu, 2 Apr 2026 11:05:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: qualcomm: qca_uart: report the consumed byte on RX
 skb allocation failure
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260402071207.4036-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <20260402071207.4036-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:DkcPyauBcYW9s5QmV0CpP4fgl89q/jwK5isfxamFSyK/AbXz8YN
 DrAruY7nUApMVi2tmPX7F1/ym2r126xdvM2nOvFL3aUSETdRhD7YF68Jyl5NNO13JApHA9/
 Xw+8l4hkAGqNcjO3aF9fP1WzTW+9S1WjGPRypvFlxA6zQB2UAXGZL8HSHE4FC9ojExwroxw
 YWw9YEYZ0gSR22xK1zYNg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:R8S166JxvdE=;g76k/S5eBO+M+AJqioGtrGQqzWz
 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
 IiKB9rFaZ5rxW2qal3cjwv3KLfuVgURYQ==
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232949-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmx.net:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wahrenst@gmx.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.net]
X-Rspamd-Queue-Id: 276EC3868CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 02.04.26 um 09:12 schrieb Pengpeng Hou:
> qca_tty_receive() consumes each input byte before checking whether a
> completed frame needs a fresh receive skb. When the current byte completes
> a frame, the driver delivers that frame and then allocates a new skb for
> the next one.
>
> If that allocation fails, the current code returns i even though data[i]
> has already been consumed and may already have completed the delivered
> frame. Since serdev interprets the return value as the number of accepted
> bytes, this under-reports progress by one byte and can replay the final
> byte of the completed frame into a fresh parser state on the next call.
>
> Return i + 1 in that failure path so the accepted-byte count matches the
> actual receive-state progress.
>
> Fixes: dfc768fbe618 ("net: qualcomm: add QCA7000 UART driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

Thanks


