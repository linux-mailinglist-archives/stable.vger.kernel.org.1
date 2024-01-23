Return-Path: <stable+bounces-15504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E84E838D9D
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 12:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E46501F24896
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 11:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7DC5D753;
	Tue, 23 Jan 2024 11:40:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17705D73B
	for <stable@vger.kernel.org>; Tue, 23 Jan 2024 11:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706010044; cv=none; b=HMgkB1DXcMVOW1l5PNTG9yr90dREQTwu1wkPupCriLH0CpgiDvJ2VcNOfihDrnUHsUFf1q+vcULbyayXrgTgENz69zDY4n15jqH1Xy5AQU0UJ8eqlwfKGnI+HfSPinaIBcXXzIDx5mGMLtjm0/bGK83S1abTpV3zPZz51Q57dno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706010044; c=relaxed/simple;
	bh=+WGJO1ib0tpz/CsTjFUFgSIrmScGErLbxca++W88gh0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ol1xhTA8ejU0jJDFi1QZw2lZ21VDQo1tKKTqjpjQU+uoAtfYU3Pj8UKfMIdtOfLqfoU/eSknGaefHNeAAUfF54YNqqcEZN8heroqFWoJTgjodweAJMNlkl7SvDltuHimTMQH21ASJh+JSYhf5tkPV7UWWxFFnvaXL0/xuYOPDRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e0cc84fe4dso2185568a34.2
        for <stable@vger.kernel.org>; Tue, 23 Jan 2024 03:40:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706010042; x=1706614842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bCJVEcyz2cVssa2KNCiknmKs1XLhxXVUcHhUVxONUMg=;
        b=LFQSCV4D1HrvWHl2vn+zpTjgVaGTAHizg7sPMJm6mlvTqdO1Gh8b7VQrRck21LhR1X
         02XtZTBjubwquNK2OZQwJcLExSCRIQUATizPw9buf7nmc5heSQXQYSQwQFCoeNgus38Y
         bMeqyr2opvzFS6XhZkW/sc25TZp/lkBntYs/U4Thhngf071ZdBOoCFFdJ/zcTAELL1gT
         WWp14k7VjaEKlxb/rOhN4+fshz2mErpFM6vZVcYHQLpTN/xtDLdrxtpjsaNcJkS3GyEs
         o34vpuj1iDNbmHXVZ2cKMovr4As38gbiNpSav233+ADlZ7lV7URwlYVAdI5lHcGUd9MQ
         SFqA==
X-Gm-Message-State: AOJu0YyzbpWK3/BWE7W8PatjhCFrQlBgsU45vw9YJCOYCgC8Z2OiMq6W
	Q2QO+/ixY6K9vJAcqey+wjfGYaO3Xfgo+AmJkoMrT+bbeJxa1zCv
X-Google-Smtp-Source: AGHT+IGX3RD1oBQIe8LJlQ0D9/IkPChQiU0vN+IVO8vUdmj/BQolBeQl+NgWdKIIAh84hItWe62DAQ==
X-Received: by 2002:a05:6870:3294:b0:214:909b:7cb1 with SMTP id q20-20020a056870329400b00214909b7cb1mr345367oac.16.1706010041665;
        Tue, 23 Jan 2024 03:40:41 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id p15-20020a63c14f000000b005cfb6e7b0c7sm7543359pgi.39.2024.01.23.03.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 03:40:40 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 6.6.y 0/5] ksmbd: backport patches from 6.8-rc1
Date: Tue, 23 Jan 2024 20:40:26 +0900
Message-Id: <20240123114031.199004-1-linkinjeon@kernel.org>
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


