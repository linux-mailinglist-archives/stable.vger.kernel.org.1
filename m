Return-Path: <stable+bounces-233305-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKyKF3eb0WkYLwcAu9opvQ
	(envelope-from <stable+bounces-233305-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 01:15:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B8739CD8D
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 01:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02AB4300B479
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 23:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322CC372EE2;
	Sat,  4 Apr 2026 23:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfH0A7GE"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D370C372B41
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 23:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775344492; cv=none; b=L4mn+SBBcVEG7bVAmOneHld3SgnXABNU0TrRifA6VK7ARID3kxaRO7yiZU9zGIAxBQ+HreidiLbDcvPf98X5f/k4SQ1oTT7ZjNUzJRU7PPZFlfQfHL9sWxUhAISM4PbnB+nOlLVIwzaAtVYMa1IWd2Vn3YUvoum0KeTRuuB8mSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775344492; c=relaxed/simple;
	bh=fKEcs7RHUYZ+YrPUGaxpiUx0Ao/tqo0DnKgDaoUiZWc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Ix8/T/x4Hv2PnnVE1I5DJOyFnwtXVTH6je9PrAYwG4+K3PgbeYV0rwQa6Blgt4vR5371mvdb7vVwQAqCYG+vlL5ZPYLJu+qDbxzHX+H/6slDjuB/Y1Skz6WYUzhUhxiIURCMNSOLta9tlcAF/MsTJReLdrUCOZcQrSQyaRFhCXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfH0A7GE; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-65005a8840dso2891242d50.0
        for <stable@vger.kernel.org>; Sat, 04 Apr 2026 16:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775344490; x=1775949290; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUrR0i7q2QNv73SNpsilSqIp/Q7gwAlZF+cW1e3Grq8=;
        b=AfH0A7GEyzvctDgcNsOoJ3BASgj3FFY8T4xPRfeQgEP+Qo2f3EqaaP9qXBw8SMdNuX
         aXCOoLU0EyspGmevRG6OT/CmWRBS2Hy7rAwpXDAcnxr/Yl/lSvHlMNYGvjycV9NcFA04
         TV+/AcbL9iflqcMCZgF/p8AQ/gyHic6OUvovMistmEFPikETd2k/HWUM+iWJaplB374n
         zMQOZSjZ4URRfP41c0Rnrcd3q8J48cPBn71Ec7OtUbnf8U6Fwig+oMHu6VQ4Xaawx3dq
         j0ZeGYMvaXs/PxWSHAo4bKZJzb0DdEK/QV7s9VJ1IqcPjYwcprQ0jVGWoxSnciwN/6uk
         bDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775344490; x=1775949290;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jUrR0i7q2QNv73SNpsilSqIp/Q7gwAlZF+cW1e3Grq8=;
        b=TN2P9a8cyoqfYRNSm8lRLySola3QqQc3BpSH5/PyftUeJpHoHGK1O6cb5ly4pKQZrp
         z8jWMlJQoI60WaieWEXkk6FrEMjqiIY6xG15FB/+gCg65r9MTpsLoKfhDmfl4fLha2vI
         EjBbVc6WLBIWPwNS9zNyn8vrpKQHuold2zAVb1PPpCbAuePmR8wJ+sPgjLVYB9YWZnOV
         KfLlnnyCwBZ0XTkk3s0U5xsm9FQouShTk57ivbbcTLwDz4iCnimy00E008Ar2wFl7vps
         wkY8mXk/5Dwzkga3JJtTzTKUg1CamoTyUelBVicfyGHRnw9HNtV6NMC6ZaTHMHTOazwg
         dQng==
X-Forwarded-Encrypted: i=1; AJvYcCUauVzSMEqIu4YMMuD6AmFMHerLwC1ZXCVizNXquRWK9YMI/g2pz8OfFBxNe8Gh/jxVpOp2ric=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL8gBg03VWTquiAHOMBifidVPNMNs7shfVPXakroEaan8zkQVp
	SOHkodWy8fWxgZ6uBrvN94NSrVur/hzlIXhwPJOa7v0a84CkZF9ZyLmy
X-Gm-Gg: AeBDietdqXOVoGZDKi4L8Be7FNmz3iBjNcdfLYGHH6F6E1WXpMRFoZ/Vn0dPYqDsZng
	2ZfhU4vdqaWwYDOmQTOs5A/d1Fi/GrL9YMKqxlP6o5HcfH4Jyd9nrVl+S2l7hg9aP1mz0fzEget
	9WSRPOWOTIRBSNawExlOQROvkKTnCJPM1ACmbqIXQS5WRpESIePSvXBZk2FLvYliRzpMwaWeMRn
	xqPC4Ti/tiEgJfCyGb9UhQdOFsVY1O7Yiz7dWGDfrV9KS5PgM1rG+1QxrVGBQ7ycOgqiJZneioF
	qWIuazoUfwGOcqSaicaa+fLBYLW7XMzAXc4ux+tUgng8VOW8qgG9+2F2haen8Ztu4C4TJrwjarf
	iQ72Vf0XADm3IBntU71qreG0RSPv1TfaJiPMH9nlFGjXZ4iob0pNFcpFvwCPf5Pw4oK0M1XmFqX
	5Bi+Qkj//Y54KrBWCWCuOhx+cSuGxjLkTtS/fRpHWjlDiv/4l78SwgIWyKshyGKVRmQa2Hll2gN
	5O++dekIc+SEKUk6luef3UyjB1zcY+C
X-Received: by 2002:a05:690e:1481:b0:64e:a0e7:2e34 with SMTP id 956f58d0204a3-650486870dfmr7177639d50.9.1775344489736;
        Sat, 04 Apr 2026 16:14:49 -0700 (PDT)
Received: from localhost ([2601:7c0:c37e:2360::17e2])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a978b7csm4079778d50.11.2026.04.04.16.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2026 16:14:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 Apr 2026 18:14:47 -0500
Message-Id: <DHKR3I6KLZWY.3VWMBF46Y41ZB@gmail.com>
To: "Delene Tchio Romuald" <delenetchior1@gmail.com>,
 <gregkh@linuxfoundation.org>
Cc: <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH] staging: rtl8723bs: fix integer underflow in TKIP MIC
 verification
From: "Ethan Tidmore" <ethantidmore06@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260404225752.61297-1-delenetchior1@gmail.com>
In-Reply-To: <20260404225752.61297-1-delenetchior1@gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233305-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,linuxfoundation.org];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	SURBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:query timed out];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ethantidmore06@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F2B8739CD8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat Apr 4, 2026 at 5:57 PM CDT, Delene Tchio Romuald wrote:
> In recvframe_chkmic(), datalen is computed as:
>
>   datalen =3D len - hdrlen - iv_len - icv_len - 8;
>
> All operands are unsigned, so if the frame is shorter than the sum of
> header, IV, ICV, and MIC lengths, the subtraction wraps to a very
> large value. This corrupted datalen is then passed to
> rtw_seccalctkipmic() and used as a pointer offset, leading to
> out-of-bounds reads on kernel heap memory.
>
> Add a minimum frame length check before the subtraction to prevent
> the unsigned integer underflow.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Delene Tchio Romuald <delenetchior1@gmail.com>
> ---

Doesn't apply to staging-next.

Thanks,

ET

