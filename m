Return-Path: <stable+bounces-240234-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONVLAV3c52nJBwIAu9opvQ
	(envelope-from <stable+bounces-240234-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 22:21:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E8743F5F9
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 22:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8FE6F3077776
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 20:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2603D8103;
	Tue, 21 Apr 2026 20:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KjqLFL/c"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06FE36826E
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 20:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776802837; cv=none; b=j4JZ14NBq4s/ECtIr6913fkzAhjA3n4x+6razxYbTkjt2B+xObajHM9b1p7ZncVZGsB6bqiX0VLOMDGyDgWdnf1kwNhESxAb9u3I1dwF5xFZqNgho4t/aGQTw1vR3Z6SQICjP//RKXMLo0xET1/vzggSNK0l+nN49vwKCvIQXQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776802837; c=relaxed/simple;
	bh=45XAOuz0OqwNn6boAX9lmria/vzaaZB2g94/HwMz0IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5/+MOZ3rJs3lT5vPJeazdon4xYXGrJ9UUx9DHcj1OQeJEHiIh4ZyPDymJWy+TrEIHhM8u54hmLrOI/uYP0eCEVI8rdVE11JkKnLO7aHVBAzAdeaWhmG4Crmshzf9iLInujOPfefK8ICCVzPHhuxNNpaA7zCMJQkFUEjKBA6Yhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KjqLFL/c; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d43e09de5so2600840f8f.1
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 13:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776802834; x=1777407634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61W3FDen/JDgh3XHK5UZj5HtIe9MHjg+PhurMbllz2Y=;
        b=KjqLFL/c9xf9acawTx4C+83P4d57AfPEVh9t9g/2neMThAWkgEbfBkDy1ClKhyoc3H
         wshlerDeqfW3VBZhTe++GU2vk+JTVBpl5d5wMfJZfV3cQWUSqIRQJJYvlrzj2ojNPUSL
         Zm1Fq4e5LHr2AO2zwlZlQpnlORCHrI9yWN3kMAffHUt3Hz2vBOluckM8Fnc/tDCdL7AS
         Ea+5ph+wg/wfa/bW+d+4bJEzWjlZNpeuArbbbhMm9JCrHpRHib59NDjZfR2o0kmGGbIO
         2lmZuM+2coogOcWyOOMYiuLjZiXZNPRRWGnnCs82XrKPRkEbFChvPqSASURb0uBop11W
         Pxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776802834; x=1777407634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=61W3FDen/JDgh3XHK5UZj5HtIe9MHjg+PhurMbllz2Y=;
        b=Lrv1yQfJiv2I7fBv+lKK3qm+qwPzBFG5w1E7GwFg0hgfWNqvImCm9O6iCGQyucPxGr
         ltGx70Xd7Ml1nKvWBxQP62uL4VRdmZuhWR/7JbTaO1fAxdJE+THn1EOEoUdpq+e+T9NJ
         UnzTzAv5PhKm06zO1qs4VNUQB56jV2Gf4e/9aKMSibSMCR84kWVUKurwTccGZt2Zlsnb
         IXUzQOmOOvviL3jY79zdtbi0X36HY4PQOJlxY+E2FOeqoDEb1R4YWxU8fP7C7oBMQiLu
         Fy0d4scPzp/PPYLHmoX8RyN1osy/4MadWvALH1FA55qCCdIfTm1FRfKcJ/aFp3ot4mI6
         AGvQ==
X-Forwarded-Encrypted: i=1; AFNElJ/f60tQtw5PgMk/AaY9GUVOh8iEXqaoh0iX6iHy438yfpAbPIXfnDZxdzechV0bnyu6eAwoYiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBVpnghCvSmhD/HFYJaQ8lpmVoNnMwm49BU+VgIqHWYB1Q907m
	pDHs3ezTA55quBvKgE2t6rB/E0AxpsmeR5IxtZIURuGgaY203tivS/7alh++MF21R/k=
X-Gm-Gg: AeBDieuXsZYxNlToql3eA1kr8I0qJCZIHGaj3gwnEeajJCJpco0hiG7nC+4VYiUw8eW
	2jE0Da8M5F9ODtLMwsxQkdurkM7wfpZj0MEmUvge+BGjvGEJBsErdRrL57kJFjNlvqCIHomsJyk
	Zexg44FH5AoGa9ZipqOLIJHT6k0WkaoPDyLsxxgU9e07wHWcLG0EmFbUyfp1lRqG68D2gpnnAbm
	Q8fliKbihSs3TaT2nuhNOaoUkmu0NrvnLGOFQsb1WKPa4MxvgSxPGqGNBNtaqc/JkAd4JvalP3T
	md8itnL8gqBHiOGh7v+1AJ8tPUlHglqo22kZqdX0yzxqE6BQupfMUpDCvdVpUaJeQsXBTDjnQYD
	MYxTHMOnfTR5upPJMilPIHThLEnibj/RGQLsYBgif9DviB5dfDsmadiw/R2HvymzC36UPhIeul6
	tIjgD1dzKNK+bJ+3gcb4d8ca9hxkgmf5vyb2RaH3ii9Cgmg7Uf6N9+sVzYMRFRCUmmI3kdUdstQ
	Igbpvyy++dRuKLRiFEVunCu
X-Received: by 2002:a05:600c:628c:b0:48a:52d4:888c with SMTP id 5b1f17b1804b1-48a52d48985mr104909355e9.3.1776802834191;
        Tue, 21 Apr 2026 13:20:34 -0700 (PDT)
Received: from localhost (p200300de374a06005c73df0aad605173.dip0.t-ipconnect.de. [2003:de:374a:600:5c73:df0a:ad60:5173])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488fb78d1bcsm171910825e9.5.2026.04.21.13.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 13:20:33 -0700 (PDT)
From: Martin Wilck <martin.wilck@suse.com>
X-Google-Original-From: Martin Wilck <mwilck@suse.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Don Brace <don.brace@microchip.com>
Cc: linux-scsi@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	Lee Duncan <lduncan@suse.com>,
	Martin Wilck <mwilck@suse.com>,
	storagedev@microchip.com,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] scsi: smartpqi: use shost_to_hba() in pqi_scan_finished()
Date: Tue, 21 Apr 2026 22:20:17 +0200
Message-ID: <20260421202018.511388-2-mwilck@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421202018.511388-1-mwilck@suse.com>
References: <20260421202018.511388-1-mwilck@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240234-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.wilck@suse.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,microchip.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Queue-Id: 70E8743F5F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

shost_to_hba() is used everywhere except to obtain pqi_ctrl_info
from shosti, except in pqi_scan_finished(), where shost_priv() is used.
This causes one pointer dereference to be missed, as shost->hostdata
is a pointer in smartpqi. Fix it.

Fixes: 6c223761eb54 ("smartpqi: initial commit of Microsemi smartpqi driver")
Signed-off-by: Martin Wilck <mwilck@suse.com>
Cc: Don Brace <don.brace@microchip.com>
Cc: storagedev@microchip.com
Cc: stable@vger.kernel.org
Reviewed-by: Don Brace <don.brace@microchip.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>

---
 drivers/scsi/smartpqi/smartpqi_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index b4ed991976d0..65ff50982978 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -2642,7 +2642,7 @@ static int pqi_scan_finished(struct Scsi_Host *shost,
 {
 	struct pqi_ctrl_info *ctrl_info;
 
-	ctrl_info = shost_priv(shost);
+	ctrl_info = shost_to_hba(shost);
 
 	return !mutex_is_locked(&ctrl_info->scan_mutex);
 }
-- 
2.53.0


