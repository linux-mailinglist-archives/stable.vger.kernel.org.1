Return-Path: <stable+bounces-4937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7282808CC4
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 16:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF8891C208A3
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 15:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AEA44C82;
	Thu,  7 Dec 2023 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLt53Gku"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B351A4209
	for <stable@vger.kernel.org>; Thu,  7 Dec 2023 07:55:01 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c09b021daso13852025e9.0
        for <stable@vger.kernel.org>; Thu, 07 Dec 2023 07:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701964491; x=1702569291; darn=vger.kernel.org;
        h=reply-to:date:to:subject:content-description
         :content-transfer-encoding:mime-version:from:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oFz3Ug8s3W34bq0JUJvpn3d805TVgn5tO7UMghaa1Ao=;
        b=SLt53GkusGepnfyv9tJcHL/bbz4rYxi2zu8DZI9aP8JTUTj44ymEKnU/Vm7uWLCtaD
         hnt40bEX0BfK0+xMd6Mwms8e2ycNGKjnToa2FpBTMPxpgcE0NGo0+JDbYDZQodUAF9eZ
         qxbuRxbsNMWhM8D3HlbK5+LzFb8dV5qjVirq/1vYwmpqTu7uA4ydfvEznv0Mkd8PBQhf
         54fBWbkhCsi9aQxW8B5R+BAR01TsQfpKHBHRnDRXD8rkOS8D6DhB68/aa2BpPUFNkaSM
         zYUo/BncEBAFz+3Wr8ldaL/B6ekFYm8SM9sYxV76yIm5uuI25f+G4e/TYdmUzARN3EDh
         2zfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701964491; x=1702569291;
        h=reply-to:date:to:subject:content-description
         :content-transfer-encoding:mime-version:from:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oFz3Ug8s3W34bq0JUJvpn3d805TVgn5tO7UMghaa1Ao=;
        b=HDZ1cFmBmHxXZUwZEAGuGMOZO0VWS2k9DSyl4aBta5gQ8LSqj5z1kJQE0iHjvFMWiv
         BxFUvmRG7YAcUW55i7hSJp2f2hScl8xPIH+Xu5UdJG5L6ixy1cAfoNZeHSgOWtN5eY9u
         LR0tQAj3ZkVT9n4Tjc0FKJevDzDPcr8J2iAx3KY36/PFOEyLnVKvwHdI/Zru5QDbCmud
         Y/Emvcr6JWnNunQtcN/QXvJGEjzPXGNhJuJ01vlooDATHNon5/qxd3xZtK2O/CmgbVaO
         x5AtZKVA8gSrGL9Fs7HeEyr5B+bgiWvOxRZfd98YSAW4Vb//Yh4NmoQQB2j5AebnZrqF
         xgJA==
X-Gm-Message-State: AOJu0Yw3NNGE1ga8/Urv2CwburMqUVJ4zh2Gk/l4dNBBpIlgL/DVBi89
	mP5r7t5rI26kiQA1jtIlFi3RocNqP+XHyA==
X-Google-Smtp-Source: AGHT+IEVXHdNIWxcr56/gRxIheZ2CMwLoIToXFgmsAiF4xRy6uIjzC9MhgrY3eS9MZ0Bbl55mjwl3w==
X-Received: by 2002:a7b:c4cd:0:b0:40c:71a:3cac with SMTP id g13-20020a7bc4cd000000b0040c071a3cacmr1581855wmk.218.1701964491451;
        Thu, 07 Dec 2023 07:54:51 -0800 (PST)
Received: from [192.168.1.87] ([196.170.65.203])
        by smtp.gmail.com with ESMTPSA id j17-20020a05600c1c1100b0040b48690c49sm89436wms.6.2023.12.07.07.54.50
        for <stable@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 07 Dec 2023 07:54:51 -0800 (PST)
Message-ID: <6571eacb.050a0220.8d69d.072a@mx.google.com>
From: Patricia Horoho <tkoufiognan@gmail.com>
X-Google-Original-From: "Patricia Horoho" <patriciahorohh@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re:Hallo
To: stable@vger.kernel.org
Date: Thu, 07 Dec 2023 15:54:48 +0000
Reply-To: patriciahorohh@gmail.com
X-Spam-Level: *

Hallo,
Haben Sie meine vorherige Nachricht erhalten, die ich Ihnen gesendet habe?

