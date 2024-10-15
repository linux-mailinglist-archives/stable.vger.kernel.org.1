Return-Path: <stable+bounces-86350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A88F99ED78
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 15:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24A9F1F24F2D
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98851B2183;
	Tue, 15 Oct 2024 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xk5ynw7K"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430E33399F
	for <stable@vger.kernel.org>; Tue, 15 Oct 2024 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998846; cv=none; b=EjxYo0ZejvLiviFtLaRd7JqaPYgw9ayW/QNMuE/VBwZckOmFB7w+lNi6uk8OFt3E3iMejSEcLR/Of8DdwdUcYMoFU2xeXNNyh1HkaGrE5VRTBmOm7+vDlWNMN1J8uoIq7y6T22M12XXzfgmv5zrg2Teb/mFTr+vNw36+qX7Nncg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998846; c=relaxed/simple;
	bh=X5igsxmbMJp2qUjqNrxwMaTJ2Q94C8hYnesRWGv9+Oc=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=YxE7dInHqzbaw+Ihm+EQFwt8a/RNwVH8nX7kAuZGLcyarfzdLCYqCJNNwG5pNEQaqEbIfjBR0tJ9XWNZRZBi9zH0RdOvrqNrClWqWnVqHdQ08vmJCczFcnpgXGJAaM/fu8R1C7v/plsQMqm/BRyiaZDM3Wpv9MWZS9sgiGySqT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xk5ynw7K; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-20c693b68f5so55000445ad.1
        for <stable@vger.kernel.org>; Tue, 15 Oct 2024 06:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728998844; x=1729603644; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5igsxmbMJp2qUjqNrxwMaTJ2Q94C8hYnesRWGv9+Oc=;
        b=Xk5ynw7KFpjFK+mIoZShhPbhXxXiWDVoxjSIs+yjTE8axjKmHPiZD730vV1mzcecJc
         vUHsy72S2OV9TSzG1U33CHKCSCqFAwHg5mod8mCfQ8R3Y8C9ViC30+1trEek0xBeqSVv
         RoNVGb+2mrJ9XbfZKUvKLKfyHATfMoZnUZIMIpBrd+WFl1OBoy1yAPFgdgQSpbCMxrAl
         Nv8vRNzCcrlWHB5qJpFwgqEAqzJtXDFLTrfNmbAScTLAZrROpZkl3xcwzTAbO9hd40L3
         ir2niSOZe35kml1Sn5oJcrkCVvukA1lc/U8dRhPXd4kuDEI+x3whPkADYgJ2EnQl9RQw
         mtZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728998844; x=1729603644;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X5igsxmbMJp2qUjqNrxwMaTJ2Q94C8hYnesRWGv9+Oc=;
        b=i1li0TKfU01JbvJ/iv/GFCY6MEAnfBVhwOhqrYRs5VGrBq+Ul4s6qi7hVSHIJ6tCrG
         vesXD62lQNd+Xu3rQrnxqZ91+H32o5nySqQa2mf5oZiNg+mpuXfJbVfGtliXw8u4R8Ww
         gDR1gVooJgno2pnyVV/EcbA4RwFxn54hnw1Impq/z6PG9oHFIwZqrfb0/qy3OfC2vSve
         4moibkP8jnUCr2tgSQOefGTrrsurYM8IbY7/zN+9M49Igdzp0m+EDzex65o9Qj4MjHpH
         B/hcleBj41Nx+kz8nsnGsXLKTWn1SHqtJOmMgjg3umyKBubX6QNHdmPoUn/FIEpf/sKR
         STJw==
X-Gm-Message-State: AOJu0YzLPvyoSjF+TDXluwHMzXVPV8Yi0cpOjG9r6vutYV8pzdiXmd5k
	EW4Lw94sAw3HI76NWcUr7f3hgbB1e83GFcCl2QqJJvrM/dbm/EqBeibEzgZ5
X-Google-Smtp-Source: AGHT+IHAfABzpBraDC6sYSDSlqWWgVrXCcJQHi7J7P+lvBaD4S19zSd94ZOjAA5aYn87YjbQduw6+g==
X-Received: by 2002:a17:902:e845:b0:20b:b26e:c149 with SMTP id d9443c01a7336-20ca1467cf5mr209672755ad.29.1728998844080;
        Tue, 15 Oct 2024 06:27:24 -0700 (PDT)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1804c066sm11745635ad.224.2024.10.15.06.27.23
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2024 06:27:23 -0700 (PDT)
From: Josey Swihart <zfrtpaliz@gmail.com>
X-Google-Original-From: Josey Swihart <joswihart@outlook.com>
Message-ID: <f4af073cc3c25acccbdb5abae7ee07642d9990afda3a15cd1477bc358d40f20b@mx.google.com>
Reply-To: joswihart@outlook.com
To: stable@vger.kernel.org
Subject: Yamaha Piano 10/15
Date: Tue, 15 Oct 2024 09:27:20 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,

I am offering my late husband?s Yamaha piano to anyone who would truly appreciate it. If you or someone you know would be interested in receiving this instrument for free, please do not hesitate to contact me.

Warm regards,
Josey

