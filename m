Return-Path: <stable+bounces-132321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 027FEA86ED5
	for <lists+stable@lfdr.de>; Sat, 12 Apr 2025 20:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E982189FC33
	for <lists+stable@lfdr.de>; Sat, 12 Apr 2025 18:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFD221ADC7;
	Sat, 12 Apr 2025 18:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSOcUrku"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3640D1C3C08;
	Sat, 12 Apr 2025 18:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744483121; cv=none; b=hRPBVtqhHwRRlG5IAmRVf3zJcgSoRc/FZ90A3Nh+LUiNIcZ1HBXluJ/rOs7yIWF9MmcnAwYZ9OAb7Ff+2vb8KQQhPIZmlSjAMqt3cCDq+GEqDmE54ed0PQWzO56W6+jPMyrPafM0tVdTv9rkvIm36Qss8b49DRS+Bg3diZKEKpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744483121; c=relaxed/simple;
	bh=qxcy0FfdjGh7AAF60opuU2EqK81hdzm1pQJ8NUSrICk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=POrtJzaqa9+DEJBCzzOzRh/XyocdkrWipGC8x8/MYHrxPgNkBs9wLzXopCphh2vDr8wa4a/ChDKN/if35ARYYhwDGM2dAfu2LH9dU+rIBZBbsuRy9CeseqOq/fvyhbMKjv0WWBZ7Dox8n1t2Nmx4SEswzDSpNtErTqT1GzyyqLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSOcUrku; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso23004015e9.2;
        Sat, 12 Apr 2025 11:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744483118; x=1745087918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s9gisPQjnG9jpPLrR1ZKCJyzGMn74eV0TOMh3IuxXps=;
        b=DSOcUrku+YpXd/DMbrwUPHJp9yRsemTnNclYu7ozLJFNXUiCwrmM5DdIqTx9Z8DvPE
         zdSbYjg2n3wjhgaSJWmTZtOw/lcIkg40kUiUcepytNRPWO3zMVBu1BDQQrK15o3mfgYk
         xAhPWbrGXU1tTgD0eYhZknxS8lUCYor49k0bpxXtmEQG77w/F+wUkOge4bVEdk7KiIKi
         Et1Nungh6GbHx4OVQ242nrv5ZCyqR44vs+fGI0j2BZz59s94CAL/pfUe6CCIVbkGsGuX
         I4CG8Q0xYXljEG5WRzCH56TwR+P89oKu+X9B8n5H/C08hJMQk3RDnAKIGVsTyr2nZ1u2
         2gfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744483118; x=1745087918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s9gisPQjnG9jpPLrR1ZKCJyzGMn74eV0TOMh3IuxXps=;
        b=Fc/GPKO21bfSiRHzl5U1Za103IV342eqJ9YjTPGuG/PSdH1/bO8Ac07upp4gCuoslh
         Hy4n3XLEEqS8VKdt8VAkuJONAS7RlV5Zo8p8j1fLVHkoUwa/zvttKbS1+0SSqiSxSuK0
         9RjmgtFTbga5EmRKi2NOYohCfbXoF4IfQVCZ1ZGExi/1kkydyaYcKyzftNY5ov0//Lq3
         Ri8G2LfZMe2IEgtUDV0ytwqYnIPsvJjdoeDUNHYD4a02iRk5ne4AkhK3CO4lqJxloA3G
         /0T/O9+gNNXTdQkIHqP70Kx+DKEAlQqAapCFMAu6oEXplj0O7Gc99xw0orsGAX8+0vzQ
         HaTw==
X-Forwarded-Encrypted: i=1; AJvYcCVKPdc1NsBW2XIkHWfSCNrwNsBCKClqB+B0EPubhTd7cUViIqHHS2hChEWoWk+X7OYb38cXjFFGQN3n@vger.kernel.org, AJvYcCVO/XMgRPQ6a/ZRORAjqFa1YwASLHqhXEqm9b7PaB3/eEgoFvGcwt+R1kOJV17bJE9aqHepkWst@vger.kernel.org, AJvYcCW+zYe2xYU5viVqAX1y7336B/VnNlq5ncSOF/OFvxwX3ZSWqMVysYRjo305qyfpV67LlevwZYqeXjBxJ0A=@vger.kernel.org, AJvYcCX6nLxBIAJbOn1aGut2FsHYhXdj1I31jXBcO1EYyXcezjQG5++rPyOZKD8pbQuBcG/Soac1L3AT@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3kSDmtuK+K2QjUpjsSnJkGEWCEvd8ZQynXQCWy/9qAIkzouyd
	6Z2UguIR3U3FbBZXbj4AapjTA/sitS+C06h4vTzxbGa2ZEsLibzC
X-Gm-Gg: ASbGncvNMm03sva5F6+G2A3TigI+QVWC6U8cwM6RN30Uol9rU6dJ+6Ui3pJPSH0fEye
	Dh1z/bvSvszMWSb8UArgTwz/BOndJlekfja5gaGJn+ZuzC9cAvbUKWeuzuX9MofaOhGMhLy+yre
	futpraaaXY8KebIzhUOrprqIwVvfY523sGHSjGe71y6nNAbSUEdHdOZWsfKLKLnI+uRspByxNrK
	B71PPhFybFcX4/6QfjGvoPtbhe8KaAhLrpHs9qeIUno2gGALAr24wHgc0lsCDS988vpxelPukle
	IOJn6HsKSFpvkJA+mKMgfVQwOBgrLJtM6mUR+Hf7Y2Dqqd/Y0GhJlmh3/antSLJ77w==
X-Google-Smtp-Source: AGHT+IFR7mxHjBPjFVXUJpWZ/+3fCdlG6JHP+8K+2Kc8E8YzLmgTezRgDejxJhR0zvfJ3dXp44O+2A==
X-Received: by 2002:a05:600c:1d93:b0:43c:e9d0:9ee5 with SMTP id 5b1f17b1804b1-43f3a959c51mr66826555e9.18.1744483118061;
        Sat, 12 Apr 2025 11:38:38 -0700 (PDT)
Received: from localhost.localdomain ([2a02:c7c:6696:8300:f069:f1cb:5bbc:db26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233c817dsm120599515e9.23.2025.04.12.11.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 11:38:37 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Cc: Qasim Ijaz <qasdev00@gmail.com>
Subject: [PATCH 0/5] net: ch9200: fix various bugs and improve qinheng ch9200 driver
Date: Sat, 12 Apr 2025 19:38:24 +0100
Message-Id: <20250412183829.41342-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series aims to fix various issues throughout the QinHeng CH9200
driver. This driver fails to handle various failures, which in one
case has lead to a uninit access bug found via syzbot. Upon reviewing
the driver I fixed a few more issues which I have included in this patch
series.

Parts of this series are the product of discussions and suggestions I had
from others like Andrew Lunn, Simon Horman and Jakub Kicinski you can view those
discussions below:

Link: <https://lore.kernel.org/all/20250319112156.48312-1-qasdev00@gmail.com>
Link: <https://lore.kernel.org/all/20250218002443.11731-1-qasdev00@gmail.com/>
Link: <https://lore.kernel.org/all/20250311161157.49065-1-qasdev00@gmail.com/>

Qasim Ijaz (5):
  fix uninitialised access bug during mii_nway_restart
  remove extraneous return that prevents error propagation
  fail fast on control_read() failures during get_mac_address()
  add missing error handling in ch9200_bind()
  avoid triggering NWay restart on non-zero PHY ID

 drivers/net/usb/ch9200.c | 61 ++++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 21 deletions(-)

-- 
2.39.5


