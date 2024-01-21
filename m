Return-Path: <stable+bounces-12325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6525883560E
	for <lists+stable@lfdr.de>; Sun, 21 Jan 2024 15:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A290281DC5
	for <lists+stable@lfdr.de>; Sun, 21 Jan 2024 14:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A6C34CDE;
	Sun, 21 Jan 2024 14:31:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FDD14F7F
	for <stable@vger.kernel.org>; Sun, 21 Jan 2024 14:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705847460; cv=none; b=sd5UcZLmdj5UsMjVuW+zWR5Pjs7lKFGSywUEO2CAHzxa4ncXMPQusZE/UG11KxC5TqEtb8B/tQjUCfelzqMhaL6GorY5W2LUgYS4GtVj5KKkqQU02LxJwMYLJwp0YvOHlqJIi69CwAxG5omps/whGO8j+2ka/eLQcYC79wiHNJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705847460; c=relaxed/simple;
	bh=+WGJO1ib0tpz/CsTjFUFgSIrmScGErLbxca++W88gh0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j5M0Qr3reW8Lpst3YgUfD+ziORmpoPqNDd6BPggj5QdeWO0lDRfnw5URWHwy8xKJNTx+39e8ukYgZoKZ5OiXzduM0NfzeK3chVRdp/tqieBOijBNzstsl8Uxd3vMv8HTtmwNWr91quvJjUYsQXPJCvYQLVtXaLNIhWRMYO45UJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d74dce86f7so1407275ad.2
        for <stable@vger.kernel.org>; Sun, 21 Jan 2024 06:30:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705847459; x=1706452259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bCJVEcyz2cVssa2KNCiknmKs1XLhxXVUcHhUVxONUMg=;
        b=qr9sypaLeQ9SmotH6LyCiLjo0aYCQfk8gE3lRe8n3FNdsgZuzE90zTiT16aEpsRemd
         W0PoJA6P7I0vxNoBLHB2blKmAqKqvEAZzg/ex/QOwusTgxQqcWD1rqYc79uX1+32pvI0
         qavm+BAms/EIrsDXDGlSrIE4YHjwGa7xwyJroJEFgKM7ITA5iHcIbARz24jvApNefzhr
         0BRKYGVHxZLGIoB4x/Jnaxdj7PcimWfAzSsX9d8TR+izMLCDQTu7TBFqjYpu7+ybmE90
         K34KKqw8IJbBCUSeDF7eNCNarcdSXaX/60F1HtwA6a8F2PugyCX1t4xqCY7GhBehDtS+
         6sJA==
X-Gm-Message-State: AOJu0Ywxh/HezBPR1ua5wEhb6elXOdp0rs3yoGmrhemrozQAXVwMDDgr
	pdIdj4667uefFkFyFwJ9FV9xlkNnj6Cl2UCe3eMF2G6O9XfQDbF4xTOK+oEs
X-Google-Smtp-Source: AGHT+IEiTW/8mlP/aOg+/89BOdhYyo7wwV1rrr0q2heCnLjofn2gXeGWEzDLvXrby5jaVwnog86nJA==
X-Received: by 2002:a17:902:da8f:b0:1d4:9d07:eb13 with SMTP id j15-20020a170902da8f00b001d49d07eb13mr3860372plx.99.1705847458678;
        Sun, 21 Jan 2024 06:30:58 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id r11-20020a170903014b00b001d5dd98bf12sm5831027plc.49.2024.01.21.06.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 06:30:57 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 5.15.y 00/11] ksmbd: backport patches from 6.8-rc1
Date: Sun, 21 Jan 2024 23:30:27 +0900
Message-Id: <20240121143038.10589-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset is backport patches from 6.8-rc1.

-- 
2.25.1


