Return-Path: <stable+bounces-81290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4426992C74
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 14:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C587B228DF
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 12:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1D81D26F1;
	Mon,  7 Oct 2024 12:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hb5POORb"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC99C1BB6B8
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 12:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728305971; cv=none; b=IE734UExCyTx1z9xw/ae0sbQW4bnU8drePCRPDSgrOe/E3YE9aoVilRzC3ymtSsUOIGl6sU/Re1Wv23iK0voutEsdHWsaZGTQUHTEpqvU0DRl0muvYsfqGcXBEeLNVrs+EguEQZT44cp5G+Rgatww+HIcnbx0I7lR1Sf6GfpRA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728305971; c=relaxed/simple;
	bh=3ooZ9kmhaJWNAXtfTvyJozS6mAsQny3tJLdHcEAZzCQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=YGhhb28tsG2UJrPMnsBpkNRR1nhxAX090ZF6mELYgJiXfLB1rcKDNfTjFzzrAGi3SC/guogI7CFYHUnmFtxYyXUmOMZupIDCqoWdsFt3pQBVo0FJ8FIgjQk3bOcxb8kbCVSclU6bvrqqXdr06eHsAwVKDFW6nWHEBfIRzyOgIiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hb5POORb; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fac60ab585so45266191fa.0
        for <stable@vger.kernel.org>; Mon, 07 Oct 2024 05:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728305968; x=1728910768; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ooZ9kmhaJWNAXtfTvyJozS6mAsQny3tJLdHcEAZzCQ=;
        b=Hb5POORb/1AeQBorgsCujR9HWuYD6cncuSIhJV2yxMsXtE5oU1tNxAnVZFTvcczwrW
         IOL5J95JkYQ6phrVECiFKWexLeYsg7T7o6P+21CS6x7SlcNkOAZqZ7NedxVw0CrH9bZz
         kniWZ5oRSIfAVEfbae/eAA6nAm1WIO9Pza6/tPK25EJwLEn9T2ug+T2DFVRSW+MBkg7p
         b/zBuCcpR1cLS1fDEIfMOaSmyTjB3JGK6VOmRBVefWOboKxd7RUUWwzUKTUqbFqDJM/Q
         AaMo1fDJNfR3u8TbxdxvzFB9ULCqlZNLbGDQp9ESwQbQqMb2xzH1m4ZWuUN16ntsrR2R
         723A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728305968; x=1728910768;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ooZ9kmhaJWNAXtfTvyJozS6mAsQny3tJLdHcEAZzCQ=;
        b=nFdduQom+J9asDjrSUAX3IrOmIVGPj37KMvIln41VCPZWwWuIJe5C9zsrajxptaHP4
         DiT7EmZTEBkvccYBt0m6ed7hi8kOBedflYpRCV3P+cK9Igeq6Bnrni73FDTs48V90fP8
         OBBctmj2au4p/8pkCDmPFMg0l2e42ITRtqj1z8OOXgpOzDW7dfdykVemZjEepZVdyPb6
         mP5n7TDE7houfm/qyTvspk8wxXekLEhrqSZ6D+Ta0BxkvBkzFT3fVB2L9cKn0HHp0j2G
         enBpbq2ezjwnYx8rEvlc6RlhBiHpwYJ2bXDDV+bLDDY4dEKbRRjvJqUhLg564HuDSJzZ
         +ZEw==
X-Gm-Message-State: AOJu0YytH2/CyORM15KkNiqNSU8e5MrpxaMJPr1nuXwQJe7a+WLtNT+R
	LS5myZOXkQ3G0azDh+t+uU0upFnpxK3ZdkpUEX3rJ6yq0TDZk5tBgNPcKw6B9tdKKsvfvL6SFLZ
	KPU3px31/dyqtwKJyeVz7IGppN7svYONY
X-Google-Smtp-Source: AGHT+IFejIjcy6rykL0ZfwOH22vOCBLd6VtMsS4MiJ+gMpvLsa+1Z4nsG19vZFXMTnJtHahvQ0h5V8CRLVpLltJDykE=
X-Received: by 2002:a2e:9fca:0:b0:2fa:d2eb:c3d0 with SMTP id
 38308e7fff4ca-2faf5cdeaf6mr40973091fa.23.1728305967607; Mon, 07 Oct 2024
 05:59:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Mon, 7 Oct 2024 14:58:51 +0200
Message-ID: <CA+icZUWN_mZ8w+5ZMdNR=YsZTFZ+hRYVr31PHqKc+8tfb2uxUQ@mail.gmail.com>
Subject: Wrong tag for queue/6.1 = v6.11.2
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

can you check the tag for queue/6.1?

Link: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/log/?h=queue/6.1

Best regards,
-Sedat-

