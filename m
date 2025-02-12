Return-Path: <stable+bounces-114990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC24A31C63
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 03:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91BFC188966E
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 02:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233D91D61A2;
	Wed, 12 Feb 2025 02:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Gkd7Xqx5"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f97.google.com (mail-io1-f97.google.com [209.85.166.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0E81D47AD
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 02:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739328939; cv=none; b=RA1GWzJSZ4Wb5BGYIBSESmy5vwz4hN0rPihxsCxwQF6WMclbS4q65Ie0MPxQTiM8XitxFA5GktFituOjT9p0eMM61IAYIsr+QKkT5EkciYCBYAmOk9Sweid7ORooveDKQJUz/RMlkON7mjtGN9/2rrKk14if+l84uZb7cWCWhZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739328939; c=relaxed/simple;
	bh=2ad/znqCNoyQ+ZTs2xBkO3ND0L+BNXu6FMlZtVsnzS4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=GjPCz6A2zDsLKoHmpmuRya+ccBuq6oCLfavibvoaNZjzyDeQUnob55llFS5v0T82KRfd+xXJHu4w7wk2FzanA08ppNSElSaZrlnLOPQvu95LbAx9QbYHX6hRNE74OtU6OZoGMw35Obom4+Uv2LuNOzvLYwf+BqhGccFN0UO3uwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=Gkd7Xqx5; arc=none smtp.client-ip=209.85.166.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-io1-f97.google.com with SMTP id ca18e2360f4ac-8552a0f329eso203062839f.3
        for <stable@vger.kernel.org>; Tue, 11 Feb 2025 18:55:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739328937; x=1739933737;
        h=content-transfer-encoding:message-id:date:subject:cc:to:from
         :dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8tVUaKQKbAKW1vM1CYtqG8Jnsk6c7w+FYLFg/LVTqg=;
        b=A/6blwH/S3nftrvNYkRdvOvO0leB19eH6/uRI8lmUfLLpuo6UbbU8zl/tCzgyo1HUh
         B6I+iLuau9H9vMvh56K8zkDcM8gkWJEXLEQjT3NzzTuEHx1xQpdQivybzsg+ztFAovrD
         s1NhuIjUYRZb1LYesgundqh9vPvLozzBe4sTEobPxrfy6+Y4mLOHAMAVj3WPBtLe+GFv
         VqwcZGiDDiCzs5nEGdPVclLpKpSB9hygW65CEOdsbARFvHZLrhq6/LbowTiOpcPR7j+S
         EBt2wPHmjtmjaDJblNP01rwQFA0KEcCXlNuirolcKcbaYrXomPmgVWbCtKToddOP+4LY
         aujQ==
X-Gm-Message-State: AOJu0YzgzZdqogHxmLxZv/T1oDQYN3XPeS+qGrVrargY6L4u+b5YK1iz
	mh7iwt06HbDvASvs9gRB0kXdm199y768UUj3xyGvbuA6xMSazEtiNSCMYPMT27tMkuJ0fG6xQ++
	UeE7GLeTpqhbBhRdcJ9IWChKdwlwNng==
X-Gm-Gg: ASbGncv3O4nhpiEJmEJx+gbyZmZDQOaTMcLe9r3Em8AxH62ird2qgO4gXT2kvNEoR1j
	XdR631kd/Nx+057XuTVzO5OGhI3NbxIyfZOJM5OLPiCArxXJv//fn+AFmmlzdEnCsXOkQBeeT+U
	s2ecK2SvubA3TVSzFxRv41pkhpE9OB4ssx/erBWL12UGj75L7iHK7OYVdYIQf/TByQ6DwHWDYd5
	eOJA6Qbxlrx7nILQzWbGhb9ThqbYBtQz+WNhOESNhWCnXsVeB3szofCd42ZsgRrxqmgtRjpFz3f
	shQkXq24sEakJcU=
X-Google-Smtp-Source: AGHT+IGoauzQQ3unxGhUCWuRXD2qiOu71ESdQclUlYGMrWTPjNv5kwESZ+mLTTC6pmiSys8FLf81ZN7G4gce
X-Received: by 2002:a05:6602:489:b0:855:2bc8:69df with SMTP id ca18e2360f4ac-85555dd6a10mr215851739f.14.1739328937268;
        Tue, 11 Feb 2025 18:55:37 -0800 (PST)
Received: from smtp.aristanetworks.com ([74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-4ecef0d4a31sm397423173.23.2025.02.11.18.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 18:55:37 -0800 (PST)
X-Relaying-Domain: arista.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1739328936;
	bh=n8tVUaKQKbAKW1vM1CYtqG8Jnsk6c7w+FYLFg/LVTqg=;
	h=From:To:Cc:Subject:Date:From;
	b=Gkd7Xqx5OPYRkiKEt9x4gbeAPlFpE+KUa8E+D8GbCdVUmaYS7Tr3qIuVYPbJxAxi7
	 0ppxN9+jT9nDlCNenaR3CilthfMXgTnAa6rMe+QPI96peRC+SlOBpRvs4dN7wK8tss
	 0/9tg5gWwdImVD8bBNVQAdlDNUHA4dqDQOR1oLzNd56aXyXRMjAtsxpzO57algscBi
	 j/e/GTpbgp5e8+nfd4xj1N+fAxeryipBux95ajuCsre2uP8MFFdWyHRaBEMixT8Fr6
	 fSAsMKA1T5pLyD15AqWwo8eN6sSdWqvkOw0FXwYCuOsASb0MdeNaOoqRg0tPZDyEe/
	 FjWeOPRzxRk3g==
Received: from visor.sjc.aristanetworks.com. (unknown [172.22.75.75])
	by smtp.aristanetworks.com (Postfix) with ESMTP id 33ABD10023B;
	Wed, 12 Feb 2025 02:55:36 +0000 (UTC)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
From: Ivan Delalande <colona@arista.com>
To: stable@vger.kernel.org
Cc: Olivier Matz <olivier.matz@6wind.com>,
	Xin Long <lucien.xin@gmail.com>,
	Ivan Delalande <colona@arista.com>
Subject: [PATCH 5.4/5.10 0/2] vlan: fix netdev refcount leak
Date: Tue, 11 Feb 2025 18:54:53 -0800
Message-Id: <20250212025455.252772-1-colona@arista.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

We started hitting the same netdevice refcount leak that had been
reported and fixed in mainline, and that Olivier had backported into
v5.15.142. So this is the same series further backported to the
latest v5.10 which fixes the issues we were seeing there.

This version also applies without change on v5.4 which should also
be affected, but it was only build-tested there as we don't have an
easy way to run our tests on that version.

Reference: https://lore.kernel.org/stable/20231201133004.3853933-1-olivier.matz@6wind.com/

Xin Long (2):
  vlan: introduce vlan_dev_free_egress_priority
  vlan: move dev_put into vlan_dev_uninit

 net/8021q/vlan.h         |  2 +-
 net/8021q/vlan_dev.c     | 15 +++++++++++----
 net/8021q/vlan_netlink.c |  7 ++++---
 3 files changed, 16 insertions(+), 8 deletions(-)

-- 
2.34.1


