Return-Path: <stable+bounces-83655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EB799BC47
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 23:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC9E2B2181C
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 21:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC99231CAE;
	Sun, 13 Oct 2024 21:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKkk+Sno"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1468D2744E
	for <stable@vger.kernel.org>; Sun, 13 Oct 2024 21:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728855067; cv=none; b=KgFuzWXOSAJLFFcdupahIit2XStdDPNs2GdaIH61LMa1NkLNj1i8JVi3pGLJOsr5HO3+qp8l4wQa4QHxmtxzE/fGw3cj/stKwl5q+LOW0/9vf4wmjtpSoeMFNoyahUdThyzFwRzRXk5xGfzxY5vzVTuQfpcplvdC9VIErKfbJso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728855067; c=relaxed/simple;
	bh=5xmURMaQB+kGaBR3ftXlO/ng8uDZS60gJunFqpNO3LI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TaazYkIlDUQ2+f8QIoQryZUHG4oMdHEGUn9/h+QfBeQn+Pc2/M1FznzT/1PkJhQFIWhOW400wBpUeAhOvtJMeD3B5cjwh5SDf2KZz6ZALfZ3AS2Q4peN1LBRWPLHpxxJKnwK/KHFWO7piA15/FSenVM22Aqo5t5i5yRniDSu2fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKkk+Sno; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d3ecad390so2917217f8f.1
        for <stable@vger.kernel.org>; Sun, 13 Oct 2024 14:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728855064; x=1729459864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xmURMaQB+kGaBR3ftXlO/ng8uDZS60gJunFqpNO3LI=;
        b=QKkk+Sno9FDPaw5WLxsEwPk+F65Z7cyIXtPqujrdTlBx0k4pWaWVwB4xVFSwtEHLtG
         kENTboKCU1ldzjMZ1FQE11g4WnlVFgXnf/rhxGrv3ADIqfizwJ/WdN3a6/9CwfUTPIh6
         bk50E0+4ILek3tB/uVaqhv1WdmrFoZK+eCO+SeLvWyYP6+WuU5xrQOlr4c0L8G1zL8cu
         OHDlG50zQwv5tT+7eZMOTrB91r5OENN0IWfa70eRKylMLAueW/zmD/71mAsFqB3G1IKK
         xpHIjJgIajTSPPjJc1An1UVNDBn4K908FtVaOnKCpsnlk94ke8iuWBSjyOlXY7VITlZo
         jenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728855064; x=1729459864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xmURMaQB+kGaBR3ftXlO/ng8uDZS60gJunFqpNO3LI=;
        b=gbWsZqZq9c/VTL4iiWUSuVPJorV1uLEwbuRITwwX9zYKS8dL9st+vmNMsbtB7IJ/L2
         TGvFRFU1mTO/6nAubH8r5koj+EIeM03/PMJuQ0o60Km0OGUkYTiixUlSwk5b04oofQMx
         ddSF10Wh1j2oK1ZCPPuleC+oJ+1indH18LqawWe3MKJNp6oQD6eLbUZYaE61S/I5BmJX
         e/n9iifJSzuDrf1agqZTQtVjzHTuXTWMD1SlEVTN/lMU6W8g8EZj2TW4JlOlUo3mWnV2
         9iWjJM/nj6MVlBjIMnLyqafK8nIpPK12uVaAFJzg6jHbu1nhpYGwKl7A/bkdAgLgoR4b
         /sgg==
X-Forwarded-Encrypted: i=1; AJvYcCXhaMFa1jaEqwTXHJQnj5GVHnnxcGDn6r9V0i2bzE0wDkRkPQARnsc+665Kp82A/qCAjAN5JXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YysIvdeh76lrdq8CSwNJpK06BRWEod/pMaDOF9y5KJtUi5RvgJW
	D1UfkC+MCkcPq1EC+pTvA8L761C9uOcIzVxXPm6WKxeKrec20tahSj7peyIq
X-Google-Smtp-Source: AGHT+IGz9v7rDMqSJARiljy8htrk4kg2Dmg1qxC2+iB38XQ4EDYnr7OU5moms3j0Ydhr9mjD5DBZOA==
X-Received: by 2002:adf:f805:0:b0:377:94b:4f51 with SMTP id ffacd0b85a97d-37d5529bc83mr6691981f8f.22.1728855064210;
        Sun, 13 Oct 2024 14:31:04 -0700 (PDT)
Received: from localhost.localdomain ([109.175.243.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a88c9sm9639468f8f.20.2024.10.13.14.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 14:31:03 -0700 (PDT)
From: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
To: mario.limonciello@amd.com
Cc: Hamza.Mahfooz@amd.com,
	Marc.Rossi@amd.com,
	amd-gfx@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/amd/display: Disable PSR-SU on Parade 08-01 TCON too
Date: Sun, 13 Oct 2024 22:31:03 +0100
Message-ID: <20241013213103.55357-1-stuart.a.hayhurst@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240205211233.2601-1-mario.limonciello@amd.com>
References: <20240205211233.2601-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, can this be considered again please? Still facing issues with the 660M in
my Lenovo Yoga 7 14ARB7. This fixes the weird behaviour I have with black
screens, back-traces and flickering.

