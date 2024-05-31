Return-Path: <stable+bounces-47759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E416E8D593B
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 06:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EEDE1F24F74
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 04:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6586B219E0;
	Fri, 31 May 2024 04:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="DQ9m/14P"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAA528FD
	for <stable@vger.kernel.org>; Fri, 31 May 2024 04:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717128890; cv=none; b=iG7kBSSgtkGnowrWAkl744NTFVktnrImHdmuRYs4pcCkLVrIbLZiXZzR2BM1XhdkpaNOP7sWBQYPhsMk4Yhl6hJxIrt7QGVurEIzSHU0Z7b0Xw3xphouyx1rCGLgLsDjki3TMMtWFONMqGJ6jKAel7K/cr0OnBVZ44gHdglwehc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717128890; c=relaxed/simple;
	bh=y46XQ6lk4JOjvOk4SqdQs/IWmIFL7cZRC6bA1tP7H+Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=IOVPdKOLEWTlSsnjZP5q8uGOmJ162z+v9BIcNgdLFXAhCUr7wFAg03QWTGS66Esevmqeolr1PILxvQjVMfXG2xrbbK8rcjgETae+nfr93uhvSJdcP8oZGv6kVea1Wn5hKoOesQFCzp+GL73k9A+TpzFynKSzg7CYIA/KFr8t2VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=DQ9m/14P; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7e24b38c022so49965439f.0
        for <stable@vger.kernel.org>; Thu, 30 May 2024 21:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1717128888; x=1717733688; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+FJsEos2QJI9EGWR3WBAr9incfgpIElpYT2z7r2nMis=;
        b=DQ9m/14PxXhByvm5x7gQn+ph62b8sFYg55ccsowsUBwvrfCL/G+zKitV2g4zdmNWp7
         d1kbPp4xAibPwRMBtwHFWzu6aEaevkMT4pn74QMTvnvKC3nSyuvXaRvyGxxJ0/S6etPH
         VZBmj37uNyTcljtO1dC0jXiaXI9RX/VWDuPSUTUw26DOpQq3Mj73/cJDLU4UCS6pIh6s
         3f8V3fi+APcMn2FqVlmKCaq2G+4aj8uM4gfGih310Zk1h1uEexPg9QQN12J207rElHzT
         NlCW868vFXOPRL6wK9tgdzvvFg3FS9E8z2KvuehFlz244Gi/GA5Q92q+kfi9gpPTkMlR
         dRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717128888; x=1717733688;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+FJsEos2QJI9EGWR3WBAr9incfgpIElpYT2z7r2nMis=;
        b=kk3icHfLbHe2GMQ6v2qOcIbGM53APGjyfx7C9IvvKjl066b6a+AE4Y8I4rHfWmIDQ9
         P27McTyOF2A7YhjA64EH3CWtWg8pHLe1+O9wEqXRPGwnJQ4WRVuXYVVfckc/l+AEyUmk
         pPf2anj1uccTGFwlN24iUEdCQYIMp5YVCykftLll5pHHQrCXno+SrUUby59/n7Km7+XQ
         fdQC+uy5FXDHz1xW6PlOmBCPixVxXk+4ENJAX+aSyC+SWGugz1y2UxogxwS7PhKqtRL5
         Ul0VAwB0RO1Vvhqsx+I3mNNdYMtCP2IkUa3hMTNbIiEXpmauFi2j9r3Fji2JKO1FORwE
         P/YQ==
X-Gm-Message-State: AOJu0Yyz4YAaepF96SgUIRv2NWNNd6OgwTx7fSV28RuI7B4aiVKmdGoV
	LrvtKP9EbIW0soFt973RSu7v8poUIV2LAiF/Yn1KM53jzx43NJbwUtczwB9yP+1GlSxM3hiuNtd
	E6kWlqXhyS3bfhhpdcQUSDXEFUmhKi8YxvmYAYs9QW1yhCWKMIAQ=
X-Google-Smtp-Source: AGHT+IEhwIQZjfzaY/L98qShmy6TvGwY7apRLSUPR1b9O+Q1OmVs+afJcZOaFWyA7+0keZb4xAO5/FTvRshE+LQSJWo=
X-Received: by 2002:a05:6602:640f:b0:7e2:119d:3f10 with SMTP id
 ca18e2360f4ac-7eafff0aba6mr86425139f.6.1717128887530; Thu, 30 May 2024
 21:14:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ronnie Sahlberg <rsahlberg@ciq.com>
Date: Fri, 31 May 2024 00:14:36 -0400
Message-ID: <CAK4epfz7DewhGqMhfTi_gy3OEEDQQhOZb=pRs4MvxzyN=_Cy+w@mail.gmail.com>
Subject: Candidates for stable v6.9..v6.10-rc1 Use After Free
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

These commits reference use.after.free between v6.9 and v6.10-rc1

These commits are not, yet, in stable/linux-rolling-stable.
Let me know if you would rather me compare to a different repo/branch.
The list has been manually pruned to only contain commits that look like
actual issues.
If they contain a Fixes line it has been verified that at least one of the
commits that the Fixes tag(s) reference is in stable/linux-rolling-stable


90e823498881fb8a91d8
5c9c5d7f26acc2c669c1
573601521277119f2e2b
f88da7fbf665ffdcbf5b
47a92dfbe01f41bcbf35
5bc9de065b8bb9b8dd87
5f204051d998ec3d7306
be84f32bb2c981ca6709
88ce0106a1f603bf360c

-- 
Ronnie Sahlberg [Principal Software Engineer, Linux]

P 775 384 8203 | E [email] | W ciq.com

