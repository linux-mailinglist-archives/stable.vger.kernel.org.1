Return-Path: <stable+bounces-94671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D26679D6711
	for <lists+stable@lfdr.de>; Sat, 23 Nov 2024 02:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6026916159B
	for <lists+stable@lfdr.de>; Sat, 23 Nov 2024 01:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33613B65C;
	Sat, 23 Nov 2024 01:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsM25amo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD724817
	for <stable@vger.kernel.org>; Sat, 23 Nov 2024 01:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732325975; cv=none; b=cGwPb3/LfuM0Y04Wc1VD5IkndCkG5QlfJ+XSdISKSXRJYX+LtFgk9mxU6/zZ09v4HoAGw+nCEjGf/fkj2g7F5XhOxqJ8B4Cs8f9v1Q0HUBm8iMFSxO76n+eammsfm6SaQyX0tgEYGOj/TcjNcMszq4MqM/Sc58eU99g2Hdcjusg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732325975; c=relaxed/simple;
	bh=BJZkEaEZqhd9ZDf9x1IO1g6b6v7pgHIk+IkHAIgdrIY=;
	h=Message-ID:Date:MIME-Version:To:From:Content-Type; b=Cs0hnw6SO5P3dyP7ki+uZeygAic79UVn2vaMz3+pgTFnClGJ8Wl5BhPN2DnL6aLy2zMf0VrPEDSk7GbFfkpx6XU1fUXK0AISzadjRC5+Eo3DULFVGm6s68Zwc+jM2OirptEvBIX5nYJ5KqkPjZlORzvXdNWBj8Zy+Uv6xNWkUCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsM25amo; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7f450f7f11dso2066045a12.2
        for <stable@vger.kernel.org>; Fri, 22 Nov 2024 17:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732325972; x=1732930772; darn=vger.kernel.org;
        h=content-transfer-encoding:from:to:content-language:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sGPIAbQ8Yjd9paYyymwyU7UOo/bs1h1NkCC+cVxSWvk=;
        b=GsM25amollvY6X+Q5MA5bMF0VfcTRkrxAMgaEb7buf35KybSRBBOuPe3wAc3hwcbVB
         9b3IhAlf+kUA2x6/YliI/bnYLdER1fDJhH2g5RzrlfOdlAhx89VZtQoD3612kYZOw0mr
         J9RL1C4g7KYib85r8lFct8uH3t5Fd5Gm/lkfCTP76UqLwlVIkqiQrQJ2DUbII+iG665S
         Y4PNf/NYBwH8abDdQGTPrvsbx093zBK4fhaYEmhRs63Xl64QPuedsx9CVhOgYrZ3hQUp
         0J9rjZQR6iUNMFgN30/x2qhzfSiNJaPuiWa3E9d/Qym9nKnmg8Y3n6cex/FuBzDFrf1q
         jEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732325972; x=1732930772;
        h=content-transfer-encoding:from:to:content-language:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sGPIAbQ8Yjd9paYyymwyU7UOo/bs1h1NkCC+cVxSWvk=;
        b=kRlu0m1EgQtzdnGcB9axicy1Gn8SibWYTFjTp9zTf3fWm5FKQ+mUzcLywgurM1xtTw
         1iUjRis12drUpJo4xGphnW+qDo6r+ufjoDwUD9xIPRqTI3qe9SCH7EtyvSn5ZYCncesI
         7iB01p8+LCjZmLp6rOXwzLwLxXIECwq3qNrKerASDzWVEXTNJPuh7WvdMRS46zkVR+zh
         1ctqp8f/FfrC3e5f5yWA2ZQomNvpLiX0I6l9PXnXJK2tZJ84GeiNFzFFfHPOxDdIeMlJ
         I0DNr6BBOpJaDPaBTBGpzT0Z9JIZ0iEoyhnbnpQTjdH9I5pOx/ye4VSEU51pGVzCuww9
         /ElQ==
X-Gm-Message-State: AOJu0YzoxzvWV4GN5ZvzFTm8zeEvR71haScSLZGvEyDUpfQiZ8pl0GbD
	9LECIDzAmr4HTRVuoYJegteErUDmSAgA1EXEB9hhm/K818G5QSlH/2ROV8tA
X-Gm-Gg: ASbGncvCJYXdgWyTqIG830PvQNQhq27XtWi7xdjza2D2RClvIC47z5Jl9wLrM6bhkpm
	1+noxnctNyDBU9DOcD0cTTmoNHAgCswfAaMv2XYjLmrb0sndU7np3yTHtMaYEavsfVlw463RrWn
	QcN+plV8PKKujlJNIIC2GLFLOco+wkkK8hY4dQo75SVDQkoOaH7/QPF/jvzFbuKCjWd7iq8sEZo
	4UXlIDJxYsJNqi3VRvQqET8/XE0DVWPRukjkQMyMHBRHlrIXmmbtKw=
X-Google-Smtp-Source: AGHT+IGlaGwhXTEiRpHFidJKs3SkZwLT4lqAFaKPcf4zFPgq1thKwz1OIE06bMnRnHaQj8IUsF+Ajg==
X-Received: by 2002:a05:6a20:6a1e:b0:1db:ebe0:449d with SMTP id adf61e73a8af0-1e09e5ff9bemr7075505637.43.1732325972071;
        Fri, 22 Nov 2024 17:39:32 -0800 (PST)
Received: from [192.168.1.52] ([1.146.179.225])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcbfc08efsm2342819a12.16.2024.11.22.17.39.30
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 17:39:31 -0800 (PST)
Message-ID: <8db6485d-0062-4155-a623-f44b3f4c079f@gmail.com>
Date: Sat, 23 Nov 2024 09:39:24 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-AU
To: stable@vger.kernel.org
From: the Hide <thehideat23@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Who should I contact regarding the following error


E: Malformed entry 5 in list file 
/etc/apt/sources.list.d/additional-repositories.list (Component)
E: The list of sources could not be read.
E: _cache->open() failed, please report.


