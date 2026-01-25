Return-Path: <stable+bounces-211489-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFT7CfsvdmmjNAEAu9opvQ
	(envelope-from <stable+bounces-211489-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 25 Jan 2026 16:00:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C79CE8118E
	for <lists+stable@lfdr.de>; Sun, 25 Jan 2026 16:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9231530056C1
	for <lists+stable@lfdr.de>; Sun, 25 Jan 2026 15:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5D431B80D;
	Sun, 25 Jan 2026 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYHXn2LK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CE231AF1E
	for <stable@vger.kernel.org>; Sun, 25 Jan 2026 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769353206; cv=none; b=t5ojn9Sd+jmHmo10gqmTdG/jwZya1+dxGfBMUzKMDhBUQIk6wBVgJiLYyBCzPUmafbJk65VKg2NLXnLmAWhbyqgbhnWxUEO/Qy+KR0InbXMFDR8cmeIGgm5qRfWQQ8IgU4XBy0Y3t+Fd4Yxh2lLwHJzBpfdn4e0+cA251Vy/YBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769353206; c=relaxed/simple;
	bh=SoaC+bTBADZsZ6lBW8YnpUI8AOZA6Bnbyobzs3M9ObI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3XELGBMbh3MtqnZBr+v7d8+UkZahxeY8VBUKKrIpGfzw7ZMgk1JHhXmjFwVGweFhwdRe1vjFghFBNyiFvhz26z0thqQJg0ACyfUDngdB6RAR4XQNGEhdkEqTVcXpm84ddvv9TKj1SFKZyMz3jm+YHVVgql1Hu6/2sr8Uxstiv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYHXn2LK; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-81f5381d168so3589538b3a.2
        for <stable@vger.kernel.org>; Sun, 25 Jan 2026 07:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769353204; x=1769958004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9H4UePuprwIqygwTYXIxu8X5uuYTZS1QdaUvyOfOkw=;
        b=UYHXn2LKGrkiyN6q33WaTUYMzWVLWil4FfGGnFcn8Urus+oOyKYeKWF737wkc2+kZe
         oxlnBGa8fGyqm6Lbslht0creXQpnQR+KVvhI8Flp2ssU6XgkBtwmmiH9NMmu/Rg+26BJ
         v2v+RtB+X+kz7YsZWBEnqGja0cCREwjyDZTG9bWKQFLsM3t4MzYMFg1M5DydTjQb971P
         BrT66v8wTBBeQ5+dAe0IwTGwhcyrF+W58xBTCbG3dlTrIIB2IeTo78foI1HGjT4uBbri
         9ZGMwCpLYQq4mShTH5CsCn/ox4gcOtNqGd/WjfyevtjGkEYVUfaAJksRFBkUIgDnjBYA
         gUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769353204; x=1769958004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l9H4UePuprwIqygwTYXIxu8X5uuYTZS1QdaUvyOfOkw=;
        b=TuSlwoaHxp7cb84cSjRrSipDJOpdOVtywZ+WLmASFR19n2qDBm7tuq3OPW0fJ3Vc3r
         VRXh1fzjkB31p5wFynifwphlQHiB8XcnMN47vqjAyrlN1JNHh2E1fuqgJGO/dd+xAGga
         ciyV4+6kwc5/ZjlDOWBNQwxTk5lIdWe2OLI4+letZo3JIgHpToakYiohncsWRJLhGmuZ
         40r2UsTV+aBVdAO7T+qHUrnbCGjXqNPZJnk3qJzCzcxufbnHk6RpqPv3WFysycjX4EV1
         HLhU8gAeWtFZM9TKURK2GHoCwnoKeprg474oQp7TEkUpbzoZpcoIcLZWis6R9GEzyWJD
         SEyg==
X-Gm-Message-State: AOJu0YwBJivdlz4n6lcHt/xZsU65wz1ZBlZmf/uAQgOzYCOafAUM345v
	aSHoNIP8OofEZPG2TEfE4xaMWbOy1ZbM61YsDl1JXHYJjwHWiBo9NrOmvO3gAm0D
X-Gm-Gg: AZuq6aKmHdNIL5P9jSJBvLwlt/MJ91P65mYwPr+yfkITLv5/VWs7XSIdUhpHT3rQgBp
	kpFSVPRzMuQ4dwSwfRtoADPTVYbSUbbHpbzub8JrJhjSyaQe7Jb1iqq5J/L4f+ogiwmehhWqn8q
	MhJqMXk5egDSmjLvJU0tnXhvOKTAnNna2miM27Lhzj4317vSzTmRIxRR9CZxihMn2kjEb9DtLfM
	hzvuivkGkjd2hF0DTlXqpP17dlSHok4AEDZHeDv0Z23BHEQNp/8wIJhHrfExBQzSffWFHt5NI45
	Px2n2K9iHFAM3gvKvvjsDcnLb5IFJeeNzOhj6teZqPHTluI+rNAByw1yLiAbzY2p7519hpmC5hg
	3InQTQdzwb/rFkG0xTx6f8r3+Vko/kqkPJ7pcIveNiM7wF+EoxXqlhtUs9gPqKaKlN15IBoNyx6
	CZ0sX0DDmSr3fvazNHykH0AQF3rk2P1isbB9fRyidEpqhTqrc=
X-Received: by 2002:a05:6a00:3012:b0:81e:af19:34bc with SMTP id d2e1a72fcca58-8234129f502mr1472202b3a.36.1769353203933;
        Sun, 25 Jan 2026 07:00:03 -0800 (PST)
Received: from saikiran-Yoga-Slim-7-14Q8X9 ([2402:e280:3d17:646:9eef:365d:4ce8:fead])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231871dd7bsm7053317b3a.39.2026.01.25.07.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 07:00:03 -0800 (PST)
From: Saikiran <bjsaikiran@gmail.com>
To: bjsaikiran@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] media: i2c: ov02c10: Check for errors in disable_streams
Date: Sun, 25 Jan 2026 20:29:55 +0530
Message-ID: <20260125145955.54069-3-bjsaikiran@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260125145955.54069-1-bjsaikiran@gmail.com>
References: <20260125145955.54069-1-bjsaikiran@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-211489-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjsaikiran@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C79CE8118E
X-Rspamd-Action: no action

The ov02c10_disable_streams() function ignores the return value from
cci_write() when stopping the sensor. If the I2C write fails (e.g.,
due to CCI timeout, power management race, or device removal), the
error is silently lost.

While we still need to return 0 and call pm_runtime_put() regardless
of hardware state (to prevent PM reference leaks and pipeline lock
issues), we should at least log when the hardware stop fails.

This change:
1. Captures the cci_write() return value
2. Logs an error if the write fails
3. Still returns 0 to ensure proper cleanup

Returning an error from disable_streams would cause the camss driver's
video_stop_streaming() to exit early without releasing the pipeline
lock, permanently locking the camera.

Fixes: 0e98938b0157 ("media: i2c: add OmniVision OV02C10 sensor driver")
Cc: stable@vger.kernel.org
Signed-off-by: Saikiran <bjsaikiran@gmail.com>
---
 drivers/media/i2c/ov02c10.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov02c10.c b/drivers/media/i2c/ov02c10.c
index b86cae3d2b74..743d8544ac53 100644
--- a/drivers/media/i2c/ov02c10.c
+++ b/drivers/media/i2c/ov02c10.c
@@ -629,8 +629,12 @@ static int ov02c10_disable_streams(struct v4l2_subdev *sd,
 				   u32 pad, u64 streams_mask)
 {
 	struct ov02c10 *ov02c10 = to_ov02c10(sd);
+	int ret;
+
+	ret = cci_write(ov02c10->regmap, OV02C10_REG_STREAM_CONTROL, 0, NULL);
+	if (ret)
+		dev_err(ov02c10->dev, "failed to stop streaming: %d\n", ret);
 
-	cci_write(ov02c10->regmap, OV02C10_REG_STREAM_CONTROL, 0, NULL);
 	pm_runtime_put(ov02c10->dev);
 
 	return 0;
-- 
2.51.0


