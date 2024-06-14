Return-Path: <stable+bounces-52241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 939219094B4
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 01:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C05FB2398E
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 23:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119A718C34A;
	Fri, 14 Jun 2024 23:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="D7BMOjsN"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559431482E8
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 23:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718406952; cv=none; b=F4iKei8aMX3XouMsyjUCGz3/VGMdSM8uqDdmJMM6maPhzNFx1J3g3Gbgzsc5CUENJpIg+gj0DE9ZdGoXZbyziziuFA+Gfq+wTbqVMMLEiulq7LIiTDgv9QNkUiYzGAIYFYJziiWbkL8M8aKWvoLSZOF2dhJIE0pdoXiKw8pzLic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718406952; c=relaxed/simple;
	bh=JIUikaQl21VIEW0QPXD6PEy/2kHJCTYK7gJ7LUaUbcU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=YjLea3/7a73PGLd62QyHyexHEADgF2jF19F+3d5RDLDHSbiZA8I4quA/h4Bx51A8L9zYo+oUPxr+Hq9P5BoRJVpZL4EFERWAwo1o6++wj8/EH8TWr3gUMu8RuJ9enivuSo8miVdC+qpHHm0Ys+i86ypRHQdxaqbJx/E+ZtRu/lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=D7BMOjsN; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-375ae697210so10753055ab.3
        for <stable@vger.kernel.org>; Fri, 14 Jun 2024 16:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1718406950; x=1719011750; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/gjhkHB15aUvGS/oi7LDzLO5bIQenM/q5+nqUkdHceo=;
        b=D7BMOjsNmeUdfSF2glLI5oYqcRem0w9Jsjz5tVYO6YUt8P4dHb+afUWX9Q0RZnUlRK
         1iaEA7U8+1vKEsrnbtQH4YNBfA2Jrnx6iHuwAgSftRRTWAvLk3s9kJ8GXjcq9k7HVVz/
         3DdUW5SEF+Tu/c85P0qo5adV2pIps5MPbeYaqM+5e3A8+Ho7GC49LTxlCHNJn55SyoFU
         AC3dC8yrY8PkjATQ+g4es2MXvgerON2GROc371z99YgZ7zsVsg7lIb07DKAUt0nN5DCP
         ccgA2FXjqn+U0VFgsSFhCQus32AHtDQT0DGljdk6GPnpZgQweEj28+8KgouSFkY9maXR
         6VZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718406950; x=1719011750;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/gjhkHB15aUvGS/oi7LDzLO5bIQenM/q5+nqUkdHceo=;
        b=lzrHOQdLOENbmPhqZ+WSivw/QOXgjAtMPpBwxNRcd4VuH4J5gvmm+VRHg/LVgb4CJz
         EX1XMLqpCBYQSFV8aZ2sOZ9AxPQIFLFsReilPandIAWAPw2rOiz0twapROCYdvSVZKpj
         0SGW880KgA1ga64K81alSOH0jlrIRrXgHsJQzXReOhgqCtCBj0C4srXTgXRRde9lUDvq
         2+zyl04fU34FYrDXoLMWWMn9WRpAYlXeHn1Pt5pRekqXLEwN7IWh32C23WcqjAj9Obbs
         7SERFZ+JMOoL2FMtrIbHomoOYOAQhLaj/mHt87u0M1srybo2NRB9O6qGg1kmfVfmCPey
         NycA==
X-Gm-Message-State: AOJu0YxQLj8BfE/Y+6/7KKbaaLtUZanGiHbgSqfu75bw1iHGnvpztw71
	6AQoLF4x2xU1YeKgevCyh/nhmPDRDdtAeg5gbYSWn2ibvlCXSiHujV1eX4oeuhgBiRwon0wmqBF
	G8Ym8yRBbMoF6Y3mZlaQbjePfS0hTDb0b4h6ZkDrvXaNMCESlOnw=
X-Google-Smtp-Source: AGHT+IHd+h9u1JLuWqlGVlvIMmgxoC/Aszi/CXTIcs0YtW/GZbwhabskoVy0ldoq49EnwMebZ4u0b7h9Yb0twUIJcUU=
X-Received: by 2002:a05:6e02:17c7:b0:375:c461:eb67 with SMTP id
 e9e14a558f8ab-375e0e9ed6bmr43402415ab.28.1718406950240; Fri, 14 Jun 2024
 16:15:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ronnie Sahlberg <rsahlberg@ciq.com>
Date: Fri, 14 Jun 2024 19:15:39 -0400
Message-ID: <CAK4epfwxVTJBZWWcSuCYkV1F0rnq-vWTvA4TBOHzUKqjA9id9g@mail.gmail.com>
Subject: Candidates for stable v6.9..v6.10-rc3 Deadlock
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Pruned list of commits that look like genuine deadlocks that are not
yet in linux-rolling-stable

44c06bbde6443de206b3
8c2f5dd0c362ec036f02
e57f2187ccc125f1f14f
67ec8cdf29971677b2fb


-- 
Ronnie Sahlberg [Principal Software Engineer, Linux]

P 775 384 8203 | E [email] | W ciq.com

