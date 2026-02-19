Return-Path: <stable+bounces-217483-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLJ9FGFHl2m2wQIAu9opvQ
	(envelope-from <stable+bounces-217483-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:24:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4379161276
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6742300823E
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 17:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0091034DB44;
	Thu, 19 Feb 2026 17:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+FB16ou"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A344C34D4D6
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 17:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521649; cv=none; b=YS0CVY8pb/nxg7fBskSlR44qCx60SsTblGavMnh1cfNbd8OoTsfAGiOPiSnaD1pbV5nwoaSYIEwgj8vazh7ecvmzp1ukLe+pnulGG0RwZGrRultS1WFtZhGbqjMCcgX+0APS2qbPuKf21Dbu9QA9zpMmmlCO5Sp7ea3dm6jup0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521649; c=relaxed/simple;
	bh=lekjK2uDe1uc2MOBlhTLaMsslRhlHPGMvLZlub2P4xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYf+bmDob5MEcCiSASlSGRYXnKJjY+Z3sNzbJSaLES2rIXT1iZZcqzRHISoYoFRHgh4X55gHalE2oDOr6diBjO+Dhbd4ogPo1ZEh/p70IrSG+7m4mjMvBCXbwxVPALNKBQzLgcsY/SdZ98MPtMJIf6QVPNToJOPqS5+OXNBVOwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+FB16ou; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-56743b33c67so569359e0c.2
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 09:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771521647; x=1772126447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftM1GiA8R6+DU2AcQGUrMykwGQspULtym9L6NUVqUXc=;
        b=l+FB16ouM9lmKfY0fG4Csj7g6/I8S4xWTuzfjrBXdHYxSfXzQJ0/lXbRH7sDULcOn1
         GtXl+5eLkgS1fUInh6TfoK85Wj+UQ0nxzaKC/pgurE5aMNcqNNDh+Clc3h2fNWFcNvP3
         VWs0sZQN35ZW0bgHKY5HxaxIwMEeXLM1rIx4ycR+5DaVn6bSye5F/7h7+ZFNMcsaxwVs
         PY6XcytLc0mkdjbWhTyuxcCeb69eUzN8NAgwOm3yweAi/Fyww5FyTe4Bx0u2JwqKSRry
         t+/LiBiF/97d8WRvBicCASEGW5lwCjwx7UoFdqj6MWn/c2M06fsbh3lWT+1x5R/MmtWS
         PzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771521647; x=1772126447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ftM1GiA8R6+DU2AcQGUrMykwGQspULtym9L6NUVqUXc=;
        b=FMl8AMC8OpLHAW8UmB8G+76ynCoTw2pYSlF8Y5OZm+4XiY+2R1rMZ18fk3DudSh6jZ
         r2hkkRwNESCcMkubuye772EEp2AARYg93owdKmBCq6UIJMJIorD9Wtw6jwkXoW055fr4
         LTAPzj6hLTuDFhJkzE1UifZFTQoCBlUnU0pZ5ez7FaRfUf60gSS6h7T2iTWKFLS8XfyI
         CxQQjK5/B/VjRg/itw1TeWdDL5JN8R5+i5J0zGmGYA61a6fD5lmZV5KjCSsaMOORk0Me
         KNH2OGEf9sYim7c395cd3b/ATVxlCYN02hgyBjO54ktoYn5/+TbABZSZKfRY6GDZxn+B
         Gz3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvV2LZNeizwXr5zlDu0nVPTTbIYRwmzn3spmx+18Vx8HaRv/wLm/o8t1Kfxa2zam+ztlu0hnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvw9Lta7yoakZeMr/f30c+6UEb7q128YdCYwaNSvVBMGL96AZX
	et8MC1CNoZRsqQSEmW/hCiAOWnPs4DOHxCBEADtdBnjuI213T1Rria44
X-Gm-Gg: AZuq6aLq9zZ639yCzdU39qfXV5cNKBJbyDT5lDSbyNy2m/wNYqnOefsQKRMecjulPc0
	wuEij/hxf+tSFVuQxrskx/ZjhCbTo3rrNM63GLzB0TuO8+oWlnizmsOSMBuNdpAkJ9issF5D07e
	+T2PTvc6ZCjOOLicCCVPSbRe7Mobs6HB8JCCZ0opwYqOdh9RVNzPtff9bMIPKHlm8xNGch+iYFu
	0BTSTOlm8jdIjbFz+xpVLZ1VM9PtiXZ7h0q0s3KqastdjpADU+W4N9McE6KjL2yIzp51YoxOZ2v
	1HxUlBlK7qOD4UX9El1HXcIpS+3bPDUcdsocVp1Kmex0yLAaRXGFt7toOF73zRXiRL575aeFRR8
	tl+sDAXp4m+0e4sJHRWnlJu7hvOVeD1MQl3GG+vgZmTLoSNceu711lS3w04YcHYi8daNeH6onRj
	QbbNYxMbR5F67kTvLRD+IH7q9vWYgK0O6oyBWG+l9txtuiETm1i83JpcfudOmIRqkpom5228VVu
	DVRkrs+7DtOiXPmrrKrqjWKtJk=
X-Received: by 2002:a05:6122:17a0:b0:567:3d65:1eb6 with SMTP id 71dfb90a1353d-56889c435c6mr6358561e0c.20.1771521647365;
        Thu, 19 Feb 2026 09:20:47 -0800 (PST)
Received: from kernel.. ([2804:4ae8:bde0:7200:7790:b0e3:f0ba:ac3f])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-568d702405bsm587672e0c.17.2026.02.19.09.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 09:20:47 -0800 (PST)
From: Maiquel Paiva <maiquelpaiva@gmail.com>
To: luiz.dentz@gmail.com,
	me@celes.in,
	insidetf2@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: Bluetooth: mgmt: Fix heap overflow in mgmt_mesh_add
Date: Thu, 19 Feb 2026 14:19:53 -0300
Message-ID: <20260219171953.712517-1-maiquelpaiva@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CABBYNZKPyi=qz-XfiNex2oS3DaJUQq-JN7uOxip90jaaHC2cHg@mail.gmail.com>
References: <CABBYNZKPyi=qz-XfiNex2oS3DaJUQq-JN7uOxip90jaaHC2cHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-217483-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,celes.in];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[maiquelpaiva@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A4379161276
X-Rspamd-Action: no action

Thank you for the detailed follow-up. 
The explanation about EXPORT_SYMBOL makes perfect sense.

I was analyzing the function's limits in complete isolation,
and didn't realize the context of the trust limit within the module itself.

I will certainly use this as a great learning experience,
(it's never too late to learn!)

I fully agree with reverting commit ac0c6f1b6a58
("Bluetooth: mgmt: Fix heap overflow in mgmt_mesh_add")
to avoid confusion and unnecessary code changes,
since the function that calls mesh_send already handles sanitization.

Just to confirm: what will happen to the other commit in this series that addresses the blocking problem
(003ca042a386)? The handling of the mesh_pending list was indeed unprotected
that's exactly what guard(mutex) is for.

Thank you for the review.

Thanks,
Maiquel Paiva

