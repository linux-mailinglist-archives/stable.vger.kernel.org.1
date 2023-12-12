Return-Path: <stable+bounces-6465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DE780F1DC
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 17:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 101672817EA
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 16:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95C27764C;
	Tue, 12 Dec 2023 16:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPuU6Yvg"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4608CDC
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 08:07:25 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5c701bd9a3cso1214984a12.0
        for <stable@vger.kernel.org>; Tue, 12 Dec 2023 08:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702397245; x=1703002045; darn=vger.kernel.org;
        h=content-transfer-encoding:tested-by:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6+/rRm7g2CzxCIfG55UKxZ4r19EONSVxA6N9s43nQKY=;
        b=KPuU6YvgYygss0Xi+pzxiTf8hRRKOBH+9evmLk0r3fsyq+/sy7nebv1exMhm2NtqP/
         3HueKgB6fo6WClka2yWicwnzfvs61W+kyqrs8zxqavYjtKZ3I3d3uq61ck5I7bmJyvoQ
         MZoIiyD+6RLE3v4XRM/GuvjQjrzT9eTJ2xRWd/siSmby5gWFAcvXNk19dBWYUeFy7heA
         5N8cy6CDcRqyAQyE0zHGMd6IflH7i4rnMOeVF3BKu1Q384i4XS/6fdbqqDgofHnC7d3+
         M2NJ0apXnsrObXHPS73bsEW3J5ys3YEtgdqiZ0j8iJ75Gscjf4twivbqyCsrcppLFI9r
         bMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702397245; x=1703002045;
        h=content-transfer-encoding:tested-by:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6+/rRm7g2CzxCIfG55UKxZ4r19EONSVxA6N9s43nQKY=;
        b=DanxDdrDY1xbxHTBkO2BkmYLhOoxWx/dPfW+0Wl4/qGL3kl+A+spMkplE7E5ZGgOT2
         Xx7zLO+qRX9pIT5GReE56uViqPtIjdfJzKzUIZSkA8SOJrL4gpZ7B6/N2pKgyZEYQbiN
         AC3tjTYuEJOVrwQnAZOii2k52Yv7jtXodrDx8/Z1VZTRjtDocSHU0M7dBTGrAKWn3EJm
         /vuF9zQmTh40O8sp83ugxvblkpG1mav36f0N5hjvtirnK0eNBALKR2xcSeYGiaykH390
         8IhkrTu0MtQfE4alXp7ux/yM9E5cNMe6CFyyGQF3vQI0Ija6+Jdow61049zdWDrmxxKF
         N+0g==
X-Gm-Message-State: AOJu0YxtVo6dkFX0puemce3/TdEYYfkXyEkRx2wSiRbgQlHDpgCS0BYS
	BjY2IFuR/znOgD6kvL//8rjcKC9G97Y=
X-Google-Smtp-Source: AGHT+IFDDoNEWlaQT/mlftvaQPb15qkaN5xZT1ZtplksDRv/oRsZzYUDeUpJ8fqu0CtqYCH7BeEjDg==
X-Received: by 2002:a05:6a20:258d:b0:190:d1d2:570d with SMTP id k13-20020a056a20258d00b00190d1d2570dmr2218602pzd.29.1702397244441;
        Tue, 12 Dec 2023 08:07:24 -0800 (PST)
Received: from localhost.localdomain ([106.222.201.245])
        by smtp.gmail.com with ESMTPSA id it16-20020a056a00459000b006ce321a9523sm8264004pfb.49.2023.12.12.08.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 08:07:24 -0800 (PST)
From: Arnab Bose <hirak99@gmail.com>
To: leo@leolam.fr
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] wifi: nl80211: fix deadlock in nl80211_set_cqm_rssi (6.6.x)
Date: Tue, 12 Dec 2023 21:37:05 +0530
Message-ID: <20231212160705.43912-1-hirak99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231210213930.61378-1-leo@leolam.fr>
References: <20231210213930.61378-1-leo@leolam.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Tested-by: Arnab Bose <hirak99@gmail.com>
Content-Transfer-Encoding: 8bit

I've tested and confirm that the patch worked for me.


