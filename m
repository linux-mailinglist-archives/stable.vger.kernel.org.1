Return-Path: <stable+bounces-254395-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOOnGFTRFWogcgcAu9opvQ
	(envelope-from <stable+bounces-254395-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 18:59:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C1A5DA3E0
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 18:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13FDD308634D
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 16:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5003C5DCE;
	Tue, 26 May 2026 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="dT2fjf3a"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6953BE161
	for <stable@vger.kernel.org>; Tue, 26 May 2026 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813423; cv=none; b=ii1yu3+cq9q3bOUl332qy1qCpCh4R702W9++V7KAJW3IOlOfBcm0vIs57E/s+KRn/rF/FW6flj/1xzctmq7t3GuXn02ut615wxblq75TcfB29Nhn8H/nkZyowf7/szRhe7xY2rNqhMIpmF196xNKYcLVesbdOC04BUWHHwaCm30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813423; c=relaxed/simple;
	bh=s+BHrTyK+bMHO5iiJGA5ie9MctNkpfULkFQmmfjBr/M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JyVOLW103oT/GMyCcfD7k5FS8cRSHMXbAA3ZpBMBivpyVuyH1GEVi8S3cZnzZMATDOvk1BfMW9BAzoq36EDzSnD0dYPFY8URlMjh1AJGbC2UH4Oa/A4EDLxLlhJP1tL3t9IEDQjRvNqc537uKnGp6pJGVJbamhw9tooM13g3LaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=dT2fjf3a; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-43bf95c3f6fso1063548fac.0
        for <stable@vger.kernel.org>; Tue, 26 May 2026 09:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779813420; x=1780418220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGmZSJTM92Vl79lLjuAT/E/OXHWP+RudsX5qZkZ0lRg=;
        b=dT2fjf3a2HjlDfoj3CIAkKoJEEQWpI27/8dXjkpy52+zQVitgzRUTRn/EK5E7hQsr1
         2Jn67mBfpLn06Zbe2fjvN6aLdFI2MjpUOWShsve/zi8G7FfL0tgAtHZayKdWmch14pXg
         FwWOtQitmG20dFyAjXZ8QG1H0o2+qCdbajdHuNREjOua9BCe/LgKu7lQj6tvem5QSwsZ
         Ft6mIf3h45vUDPlCV59UdXW7J9mk4LX2xOsni7N0RuCuvQHLlwsGGn5PE7WgcUD0e3Cy
         ZhESZV9aB57C5DpNYZi5UnTxo5Vok4OMRrVEzfz45tn+qsSRC9O971IPQtF/hYgmQlul
         jGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779813420; x=1780418220;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LGmZSJTM92Vl79lLjuAT/E/OXHWP+RudsX5qZkZ0lRg=;
        b=DFuKYn5TDKDp8m+Wix1JEUsmZUxxpHp19d3enSShlwaIkRKLn9gVc0rpcdw6DEOh5V
         ECL75DMCH94HWu+qCjEMXC0ynuFLlXqDoGKLS+pxcona2XqOnHkKZOuuch1gBLxqoVaD
         rkNpZ1+u1bt3HjzHmluwM/QFBE5nJ3wkOB/CWjiXw13+bEDMVpIWjl5WFpSibKUyjyOP
         9+GTd+vM71LulTTUuv+mRYfuyHfxpUUZtdlbOtz6looBcjrZVRHJTvy5pYY64d+qqIfa
         JZTxgEU3SpCaXCv+m5wPDVZBNyywSKKQdd+3K9FmLhRZPEtglOcloGSMtJ7WEk/HsTPN
         4KAQ==
X-Gm-Message-State: AOJu0YxOOJm2BohZ8NwdB5aYfG1qnNMEbA0y41oe0VBqkzS/OAbkwQrv
	PccwOygqmh4nvsssdw8I2Q0GhXBn1i+M6imX3uMGGrIXvbSB5hVs2NnC6Y1CbanJ3iA=
X-Gm-Gg: Acq92OGZ2rgM4XhyfpJdfxsKifyyxA06v+e/jal4tlvDLcmZIMtyo3lGiko1yrvMAdl
	cgQcx6Pa861Zd3hvczZZf6v+AkKpv9Zno1tw653Qg6kiKilyIdelUQ2Tc4ElZMbkeEyrvl7in6I
	AjRV18c56z/K3zCVipOPRn0Xm8IjcJqNS9VqafenMrkSVn3yj8qo6T4+Tj7nCyoVrzRmUN2WUEl
	OLTC5tbLV46XmDeDU9uD/VP/gWJYJEmboYcAvFJQPnyeyDrvjSECd1PxK0EtYPyTbKMiBkHKcLb
	rQJkKFnOgHhyW35BoEbBxUKGoXvsFqh1Mz/6Fas2uABJIqbGNreW68wj5gXnkzxq5aGBBOj63UM
	YDpRY3s0XwleRxZXO2RORYZW44E+X9fY9KU3KWu2pYI8eViwwADIiKxVtUUQNOKopizBfRzSpUf
	5/4VvsfOH1b6rl0t1WiQjRnLvnXUnPw5ta5AVQ1k+siQvUhnj2PCCkqsi5qm7YtGMSjD6K9QbN1
	c4=
X-Received: by 2002:a05:6871:ea14:b0:439:b99e:4414 with SMTP id 586e51a60fabf-43b2f7fde1bmr11858804fac.6.1779813420627;
        Tue, 26 May 2026 09:37:00 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b639fd7adsm13561265fac.14.2026.05.26.09.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 09:36:59 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org, Wentao Liang <vulab@iscas.ac.cn>
Cc: Josh Law <objecting@objecting.org>, Kees Cook <kees@kernel.org>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260526102124.2283846-1-vulab@iscas.ac.cn>
References: <20260526102124.2283846-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] block: partitions: fix of_node refcount leak in
 of_partition()
Message-Id: <177981341919.464267.12762011041724879743.b4-ty@b4>
Date: Tue, 26 May 2026 10:36:59 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254395-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kernel-dk.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: B4C1A5DA3E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, 26 May 2026 10:21:24 +0000, Wentao Liang wrote:
> of_partition() calls of_node_get() on the parent device node at the
> beginning of the function, storing the reference in 'partitions_np'.
> This reference is leaked in two paths:
> 
> 1. The compatibility check at the top of the function returns 0
>    without releasing partitions_np when the node exists but is not
>    "fixed-partitions" compatible.
> 
> [...]

Applied, thanks!

[1/1] block: partitions: fix of_node refcount leak in of_partition()
      commit: 148cd4873115feb266c002d4d4618ea7f14342d9

Best regards,
-- 
Jens Axboe




