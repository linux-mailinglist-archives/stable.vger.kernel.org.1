Return-Path: <stable+bounces-270188-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IZP4OGQqRWpz8AoAu9opvQ
	(envelope-from <stable+bounces-270188-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 16:55:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 657686EF07E
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 16:55:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=CbQk3WMG;
	dkim=pass header.d=redhat.com header.s=google header.b=k4rqM0dd;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270188-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-270188-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10EA23066512
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 14:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A9F34CFA7;
	Wed,  1 Jul 2026 14:38:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02B2348C7F
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 14:38:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916721; cv=none; b=WtSLhlItliOZFv0qUJpRzyfvDIbySleVzLu+ky4UXUNN/0kTrOy84NFTSRa+0/zUb03wHmANByKjdvXw1LGUP6uzIZjXu5PncDDHVeZQRTUQz3bnqffT2aRL7cNGThGj8kSdZpWGD+jF2OHCPhDKY+3WbX2FrWQCGnNhwqeL+WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916721; c=relaxed/simple;
	bh=0YFYU1MJWgulitatJBeBn60XcAHqgrtmFbtauSxwcf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MMaeDRdijSVHWLRscPkpS9QNDiyptX9ey9UkFgDQOFPXh69t9cVYSIuHCB+OJLpMXeil6pxtXTk8rCeFS5AptuFTN4Uydut84nNltrmeWgTPx83YcUN66hum+3FaxT8Ma6bs/Ved8lEAsKNn0huwQhrcKMjSw7eFKP0Xt6tZCUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CbQk3WMG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=k4rqM0dd; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782916719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OrdNneIgH6yMJu9p2N3FIGNVTXTUUQ5T56Karm+HK5Y=;
	b=CbQk3WMGy3KKHXnnHTUYu35e87ZjLocNX/fVBif7kiAMnmHXkO64L8r/OiwmfbDCC8zPdM
	3GLAvE9aJjJLIL9NdlbPy+USAAIMuoAVDwyJrvCVSMsGQghPmJy+PyR7+QfDSgXsNkAFiq
	4NC6pOw+pmniCc2H8cW+0yOSJNhXinI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-fYXFF1-DOlGjYSAyevPFcA-1; Wed, 01 Jul 2026 10:38:37 -0400
X-MC-Unique: fYXFF1-DOlGjYSAyevPFcA-1
X-Mimecast-MFC-AGG-ID: fYXFF1-DOlGjYSAyevPFcA_1782916717
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493bdaf8549so8741145e9.2
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 07:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782916716; x=1783521516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OrdNneIgH6yMJu9p2N3FIGNVTXTUUQ5T56Karm+HK5Y=;
        b=k4rqM0ddJoE2CdEZZ4l7/DDrUt3iuKPORA/TztLaBVZ1vX1O0ETeQ0LJIO8/AoiCS/
         lFuJJMGKRe95Et4rKFmtnqUVj7vH7MhPyt937PzArsD44iV5QGHqhgSOjHjdysuksfcJ
         gz4i+yzULCLrEeLS8lkHS0Wi9KJ9IGwXQ3fSly7UuBEIk0RO+uE6ViWIpI9EbIYfzepz
         kKJ84kOrI5bo1KepoespJwMocC8iknOtcVBVrLll5KkNoir0uADBMy3aJq/9A0rlMe59
         7xnntih1JLKB/7qBgt2mq2hjB0MZTg5FBmmO4kmAO/xc0+o7rXn5C3klMn/pK7fG6znr
         1hlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782916716; x=1783521516;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OrdNneIgH6yMJu9p2N3FIGNVTXTUUQ5T56Karm+HK5Y=;
        b=mncKeqmk4fq1cXmy2LpllUXqA3JxmLOS0Ojxe/3HSWBZc1HwrLzeUQsOCXi6G7jubr
         0rwtajb7gv69WUdHah/Ei902g2yC2h4Cp5149oXfq3j7oRKqjSkRz55gbWd5xJhzx3/u
         pvVlSMu94rq9f5onJCSS2D2r6Hnxc94hxqb1HoljXS95r1NWz8S3WWy3MNAcTurku/T7
         oJbisYAuipsWp6WWntkgKd5m/JHtqkZZIv69WdrncBGYdOY5SVKXjk/RCCEEKaYlMA9I
         OzQtiNYw2m3giZadSXUdB9pukBEGsmNz4hI0/hXxUZZS27YOXnO+sdgRXjBx7QLO/RBn
         /xCA==
X-Forwarded-Encrypted: i=1; AFNElJ/ML1+kTw7GNANuZRQVQBa26YLWEAzcnYqeyX6SikTKmSDJfK0vyndi2JtMoO08wMUDIvrG2qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNgdBNZFTpDWcLbfimUY3WR5m4MONbieHtSm82mz3uAH2AhSbW
	CSfZRP9tDIFvhLWQr888nd16n4Ce9lbFZRN8znBtK50zd5SR0IwV0X3Oq5zO8sdwSwENuHgdaBQ
	Ppoedy9NlRoStZkE7ut2/XSTeSh3RTeGjaAvmZQz1ILWg+Is/M+Qg+gvkKA==
X-Gm-Gg: AfdE7cnCN7SEsGL3ThZR80eOET3FXLJHQsk/QRtnVQVggkyFtRAeljiODdx6BSQNKWS
	v0fPA0gDGfnbJyJqyJVcQ7F+rb3UlPEGorpqW0GsbvV634hbRBfGNdBdJa+nxyvMmC/7PN0DSyE
	v0Lgh4HNZq+9JZJ9aX+4U10jr+MmKo0joRY1sr3E9TwlaHjFKxa3ZfpT9PAb4ljWcNzbaoSEDXd
	OaFL1kVawFw1flftSYzJEruhutuDKNUet9WB5E0e1HTdr9vou/puMSwlRruQseHhzztgzJljsGF
	ibKOyLu8CIOh/hNTA54ZmJt4kL5PKZOsPqlItYM8LnMlFV3uXuvlSgo7xLSVXTPsfiSvpKe6cWh
	K8564hNy21Fssgxt0nfEzHBugbxlyrT9d1JCgnMT0oKIlgIlW9Fw2GJA9n2C1EXf2eALLHUzoDS
	Kn7VE4jcx7MQ==
X-Received: by 2002:a05:600c:5247:b0:493:c378:18b3 with SMTP id 5b1f17b1804b1-493c37818b6mr22702785e9.32.1782916716591;
        Wed, 01 Jul 2026 07:38:36 -0700 (PDT)
X-Received: by 2002:a05:600c:5247:b0:493:c378:18b3 with SMTP id 5b1f17b1804b1-493c37818b6mr22702395e9.32.1782916716226;
        Wed, 01 Jul 2026 07:38:36 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4540aesm81733665e9.0.2026.07.01.07.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 07:38:35 -0700 (PDT)
Message-ID: <8138f145-6a4d-465e-a45c-b8ffbf9e05bc@redhat.com>
Date: Wed, 1 Jul 2026 16:38:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: HWS, fix matcher leak on resize target
 setup failure
To: saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, kliteyn@nvidia.com, vdogaru@nvidia.com, horms@kernel.org,
 kees@kernel.org, stable@vger.kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 jianhao.xu@seu.edu.cn, zilin@seu.edu.cn, Dawei Feng <dawei.feng@seu.edu.cn>
References: <20260629064049.3852759-1-dawei.feng@seu.edu.cn>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260629064049.3852759-1-dawei.feng@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270188-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:leon@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:kliteyn@nvidia.com,m:vdogaru@nvidia.com,m:horms@kernel.org,m:kees@kernel.org,m:stable@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:zilin@seu.edu.cn,m:dawei.feng@seu.edu.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 657686EF07E

On 6/29/26 8:40 AM, Dawei Feng wrote:
> hws_bwc_matcher_move() allocates a replacement matcher before setting it
> as the resize target. If mlx5hws_matcher_resize_set_target() fails, the
> replacement matcher is not attached anywhere and is leaked.
> 
> Fix the leak by destroying the replacement matcher before returning from
> the resize-target failure path.
> 
> The bug was first flagged by an experimental analysis tool we are
> developing for kernel memory-management bugs while analyzing
> v6.13-rc1. The tool is still under development and is not yet publicly
> available. Manual inspection confirms that the bug is still
> present in v7.1.1.
> 
> An x86_64 allyesconfig build showed no new warnings. As we do not have a
> mlx5 HWS-capable device to test with, no runtime testing was able to be
> performed.
> 
> Fixes: 2111bb970c78 ("net/mlx5: HWS, added backward-compatible API handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>

@nvidia team, double checking I did not miss any relevant communication.
The last process update I recall is that one of the people listed in
maintainer file will ack patches for us to merge directly into the
net/net-next trees.

Should we consider any ack from @nvidia sufficient to take over?

Thanks,

Paolo


