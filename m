Return-Path: <stable+bounces-220921-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLsJEz5Jo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220921-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:59:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EE51C7B51
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0CABF311EBD2
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A88F42E6F6;
	Sat, 28 Feb 2026 17:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICN6ft/e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFEB42E6ED;
	Sat, 28 Feb 2026 17:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300810; cv=none; b=NPoBOMvMBs0T9+dYVaU6VA8d/nulvPqMrPXdlICLvRgKbFWO6cCegBa5Fhv9sou/rbSeIRVuUsLWGCq8hTklIyTUxZgDEQ8CSbwl4rSuilE7KXPQec/s+q/HTsKbrxAcknu8FzXNY1aPl5rKT0PHHju6MANk004XF7i+2B9VVQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300810; c=relaxed/simple;
	bh=wlnoMeWexWJA2dF9SfOHwqItuv9hz4ScmW9Lp2Fq6Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ad6ARA9Coep8lu2grIzZEhHyMfssQSPtCMTE+Fd4X39/PL+ZeIKAYW3+ry298xBJz01BC0Rt8AjOqkqHqqVt7nU6LMme5Y3QhREOa3MYBCUJLtLNDYff8C8t2kq0xVhAdJOQbehPlUetS2iq9+Gnb2lwIce/NDiT7nLQllLuIHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICN6ft/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507B3C2BC87;
	Sat, 28 Feb 2026 17:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300810;
	bh=wlnoMeWexWJA2dF9SfOHwqItuv9hz4ScmW9Lp2Fq6Zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ICN6ft/eiMKLZdgQ3qVqUDV9BZ1VhZOF0jDGHjvx/tNXdfScTRyb6UkcASKU7Vj8L
	 Oc6gi0urSyXf8V6+TcqfTCVGwz7/s4MqA0OjzoyEFFYiP4b7T5al2tjPnkTcNssAKx
	 EE6EuhCHK7f6dz+2QGjd2XI1xt6Ui1bSS5Ip7XnKCXqKmCg+NCoun45dWoDJMOjr+c
	 fMBHxCFR6EyX6jQZipSGHvuXLUom8RqGeLyhebOqHGYsJjwKGL5TQ7BBrE3tSyANg3
	 3zs5u0ZJT1L5xNk20Jc+AScrRSDosOnsI+wpaVqJlFYGQFpr6wsxEY++sYoiJ6oeda
	 8UuXlqkfiQnrA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 842/844] ALSA: pcm: Revert bufs move in snd_pcm_xfern_frames_ioctl()
Date: Sat, 28 Feb 2026 12:32:35 -0500
Message-ID: <20260228173244.1509663-843-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220921-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: E7EE51C7B51
X-Rspamd-Action: no action

From: Nathan Chancellor <nathan@kernel.org>

[ Upstream commit 0585c53b21541cd6b17ad5ab41b371a0d52e358c ]

When building with clang older than 17 targeting architectures that use
asm goto for their get_user() and put_user(), such as arm64, after
commit f3d233daf011 ("ALSA: pcm: Relax __free() variable declarations"),
there are bogus errors around skipping over a variable declared with the
cleanup attribute:

  sound/core/pcm_native.c:3308:6: error: cannot jump from this asm goto statement to one of its possible targets
          if (put_user(result, &_xfern->result))
              ^
  ...
  arch/arm64/include/asm/uaccess.h:298:2: note: expanded from macro '__put_mem_asm'
          asm goto(
          ^
  sound/core/pcm_native.c:3295:6: note: possible target of asm goto statement
          if (put_user(0, &_xfern->result))
              ^
  ...
  sound/core/pcm_native.c:3300:8: note: jump exits scope of variable with __attribute__((cleanup))
          void *bufs __free(kfree) =
                ^

clang-17 fixed a bug in clang's jump scope checker [1] where all labels
in a function were checked as valid targets for all asm goto instances
in a function, regardless of whether they were actual targets in a
paricular asm goto's provided list of labels.

To workaround this, revert the change done to
snd_pcm_xfern_frames_ioctl() by commit f3d233daf011 ("ALSA: pcm: Relax
__free() variable declarations") to avoid a variable declared with
cleanup from existing between multiple uses of asm goto. There are no
other uses of cleanup in this function so there should be low risk from
moving this variable back to the top of the function.

Link: https://github.com/ClangBuiltLinux/linux/issues/1886 [1]
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512190802.i4Jzbcsl-lkp@intel.com/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Link: https://patch.msgid.link/20260106-pcm_native-revert-var-move-free-for-old-clang-v1-1-06a03693423d@kernel.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/pcm_native.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 844ee1b4d286f..0a358d94b17c6 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3291,6 +3291,7 @@ static int snd_pcm_xfern_frames_ioctl(struct snd_pcm_substream *substream,
 {
 	struct snd_xfern xfern;
 	struct snd_pcm_runtime *runtime = substream->runtime;
+	void *bufs __free(kfree) = NULL;
 	snd_pcm_sframes_t result;
 
 	if (runtime->state == SNDRV_PCM_STATE_OPEN)
@@ -3302,8 +3303,7 @@ static int snd_pcm_xfern_frames_ioctl(struct snd_pcm_substream *substream,
 	if (copy_from_user(&xfern, _xfern, sizeof(xfern)))
 		return -EFAULT;
 
-	void *bufs __free(kfree) =
-		memdup_array_user(xfern.bufs, runtime->channels, sizeof(void *));
+	bufs = memdup_array_user(xfern.bufs, runtime->channels, sizeof(void *));
 	if (IS_ERR(bufs))
 		return PTR_ERR(bufs);
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-- 
2.51.0


